//
//  GameViewController.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 28.05.25.
//

import UIKit
import Combine

class GameViewController: UIViewController {
    private var netManager: NetManager = NetManager()
    var currentPlayer: User!
    var firstCard: CardModel?
    var secondCard: CardModel?
    private var timer: Timer?
    @Published private var counter: Int = 0
    var cancellables: Set<AnyCancellable> = []
    private var cards: [CardModel] = []
    private var backViews: [UIImage?] = []
    private var currentScore: Int16 = 0
    let loadingIndicator = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.text = "00:00"
        return label
    }()
    let difficultyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Difficulty:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let cardsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Cards:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var gameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    var difficultyMenu: UIButton = {
        let button = UIButton()
        button.setTitle("Easy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        let menuElements: [UIMenuElement] = [
            UIAction(title: "Easy", handler: {_ in button.setTitle("Easy", for: .normal)}),
            UIAction(title: "Medium", handler: {_ in button.setTitle("Medium", for: .normal)}),
            UIAction(title: "Hard", handler: {_ in button.setTitle("Hard", for: .normal)})
        ]
        button.menu = UIMenu( options: .displayInline, children: menuElements)
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var cardSetMenu: UIButton = {
        let button = UIButton()
        button.setTitle("System cards", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        let menuElements: [UIMenuElement] = [
            UIAction(title: "System cards", handler: {_ in button.setTitle("System cards", for: .normal)}),
            UIAction(title: "Cats cards", handler: {_ in button.setTitle("Cats cards", for: .normal)}),
            UIAction(title: "Dogs cards", handler: {_ in button.setTitle("Dogs cards", for: .normal)})
        ]
        button.menu = UIMenu( options: .displayInline, children: menuElements)
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var startGame: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .black
        button.setTitle("Start Game", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setupSettingsLayout()
        $counter.sink { [weak self] value in
            if value < 3600 {
                let minutes = value / 60
                let seconds = value % 60
                let timeString = String(format: "%02d:%02d", minutes, seconds)
                self?.timerLabel.text = timeString
                print(value)
            }
        }
        .store(in: &cancellables)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        gameView.subviews.forEach { $0.removeFromSuperview() }
        startGame.isEnabled = true
        timer?.invalidate()
        counter = 0
        currentScore = 0
    }
    func setupSettingsLayout() {
       
        let cardStackView: UIStackView = {
            let spacingView = UIView()
            spacingView.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            let stackView = UIStackView(arrangedSubviews: [spacingView, cardsDescriptionLabel, cardSetMenu])
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        let difficultyStackView: UIStackView = {
            let spacingView = UIView()
            spacingView.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            let stackView = UIStackView(arrangedSubviews: [spacingView, difficultyDescriptionLabel, difficultyMenu])
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [cardStackView, difficultyStackView])
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.layer.cornerRadius = 10
            stackView.layer.backgroundColor = CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
            return stackView
        }()
        view.addSubview(stackView)
        view.addSubview(startGame)
        let action  = UIAction { _ in
            self.startGame.isEnabled = false
            stackView.isHidden = true
            self.startGame.isHidden = true
            self.loadingIndicator.center = self.view.center
            self.view.addSubview(self.loadingIndicator)
            self.loadingIndicator.startAnimating()
            Task {
                switch self.cardSetMenu.titleLabel?.text ?? "System cards" {
                case "System cards":
                    self.backViews = [ UIImage(systemName: "cross.vial"),
                                         UIImage(systemName: "bolt.car"),
                                         UIImage(systemName: "pc"),
                                         UIImage(systemName: "stethoscope"),
                                         UIImage(systemName: "car.fill"),
                                         UIImage(systemName: "house.circle.fill"),
                                         UIImage(systemName: "cross.circle.fill"),
                                         UIImage(systemName: "airplane.circle.fill")]
                case "Cats cards":
                    self.backViews = try await self.netManager.downloadImage(for: .cat)
                case "Dogs cards":
                    self.backViews = try await self.netManager.downloadImage(for: .dog)
                default:
                    self.backViews = []
                }
                self.startGame.isEnabled = true
                self.setupGameLayout(with: self.difficultyMenu.titleLabel?.text ?? "Easy")
                UIView.transition(from: self.view,
                                  to: self.gameView,
                                  duration: 0.3,
                                  options: .transitionFlipFromLeft)
                self.loadingIndicator.removeFromSuperview()
                self.timerLabel.text = "00:00"
                stackView.isHidden = false
                self.startGame.isHidden = false
            }
        }
        startGame.addAction(action, for: .touchUpInside)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            startGame.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGame.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    func setupGameLayout(with difficulty: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.counter += 1
        }
        var gameFrame = view.frame
        gameFrame.origin.y += 100
        gameFrame.size.height -= 200
        gameView.frame = gameFrame
        cards = getCards(difficulty: difficulty)
        let coordinates: [CGRect] = getCoordinates(difficulty: difficulty)
        cards.shuffle()
        gameView.addSubview(timerLabel)
        timerLabel.frame = CGRect(x: 0, y: 0, width: gameFrame.width, height: 50)
//        view.addSubview(gameView)
        for card  in cards {
            card.frame = coordinates[cards.firstIndex(of: card)!]
            card.bounds = card.bounds.insetBy(dx: 5, dy: 5)
            card.setupLayout()
            card.delegate = self
            gameView.addSubview(card)
        }
    }
    func getPointsForCards(numberOfRows: Int, numberOfColumns: Int) -> [CGRect] {
        var coordinates: [CGRect] = []
        for row in 0..<numberOfRows {
            for column in 0..<numberOfColumns {
                let height: CGFloat = (gameView.frame.height - 50) / CGFloat(numberOfRows)
                let width: CGFloat = gameView.frame.width / CGFloat(numberOfColumns)
                let xPosition: CGFloat = CGFloat(column) * (gameView.frame.width / CGFloat(numberOfColumns))
                let yPosition: CGFloat = 50 + CGFloat(row) * ((gameView.frame.height - 50) / CGFloat(numberOfRows))
                coordinates.append(CGRect(x: xPosition, y: yPosition, width: width, height: height))
        }
    }
    print(coordinates)
    return coordinates
    }
    func checkCards() {
        if firstCard != secondCard && firstCard?.backView.image == secondCard?.backView.image {
            firstCard?.disappear()
            secondCard?.disappear()
            cards.removeAll { $0 == firstCard }
            cards.removeAll { $0 == secondCard }
            currentScore += 10
            if cards.isEmpty {
                if currentPlayer.highscore < Int16(Double(currentScore) / (Double(counter) * 0.1)) {
                    currentPlayer.highscore = Int16(Double(currentScore) / (Double(counter) * 0.1))
                    print(currentPlayer.highscore)
                }
                let alertController = UIAlertController(title: "You won!",
                                                        message: "Your score is:\(Int(Double(currentScore) / (Double(counter) * 0.1)))",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    self.dismiss(animated: true, completion: {
                        UIView.transition(from: self.gameView, to: self.view,
                                          duration: 0.3,
                                          options: .transitionCrossDissolve)})
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                currentScore = 0
                timer?.invalidate()
                counter = 0
            }
        } else {
            firstCard?.flip(completion: nil)
            secondCard?.flip(completion: nil)
            currentScore = Int16((Double(currentScore) * 0.9))
            }
        }
    func getCards(difficulty: String)  -> [CardModel] {
        var cards: [CardModel] = []
        backViews.shuffle()
                switch difficulty {
                case "Easy":
                    for card in 0..<3 {
                        cards.append(CardModel(frontImage: backViews[card]))
                        cards.append(CardModel(frontImage: backViews[card]))
                    }
                case "Medium":
                    for card in 0..<6 {
                        cards.append(CardModel(frontImage: backViews[card]))
                        cards.append(CardModel(frontImage: backViews[card]))
                    }
                case "Hard":
                    for card in 0..<8 {
                        cards.append(CardModel(frontImage: backViews[card]))
                        cards.append(CardModel(frontImage: backViews[card]))
                    }
                default:
                    return []
                }
                return cards
            }
    func getCoordinates(difficulty: String) -> [CGRect] {
        switch difficulty {
            case "Easy":
            getPointsForCards(numberOfRows: 3, numberOfColumns: 2)
            case "Medium":
            getPointsForCards(numberOfRows: 4, numberOfColumns: 3)
            case "Hard":
            getPointsForCards(numberOfRows: 4, numberOfColumns: 4)
        default:
            getPointsForCards(numberOfRows: 3, numberOfColumns: 2)
        }
    }
}
