//
//  GameViewController.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 28.05.25.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentPlayer: User!
    var firstCard: CardModel?
    var secondCard: CardModel?
    var currentScore:Int16 = 0
    var gameView:UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    var menu: UIButton = {
        let button = UIButton()
        button.setTitle("Easy", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        let menuElements: [UIMenuElement] = [
            UIAction(title: "Easy", handler: {_ in button.setTitle("Easy", for: .normal)}),
            UIAction(title: "Medium", handler: {_ in button.setTitle("Medium", for: .normal)}),
            UIAction(title: "Hard", handler: {_ in button.setTitle("Hard", for: .normal)}),
        ]
        button.menu = UIMenu( options: .displayInline, children: menuElements)
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var startGame: UIButton = {
        let button = UIButton()
        button.setTitle("Start Game", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupSettingsLayout()
        
    }
    func setupSettingsLayout() {
        view.addSubview(menu)
        view.addSubview(startGame)
        let action: UIAction = .init(){ _ in
            self.setupGameLayout(with: self.menu.titleLabel?.text ?? "Easy")
            self.navigationController?.isNavigationBarHidden.toggle()
            UIView.transition(from: self.view, to: self.gameView, duration: 0.3, options: .transitionFlipFromLeft)
        }
        startGame.addAction(action, for: .touchUpInside)
        NSLayoutConstraint.activate([
            menu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            menu.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGame.topAnchor.constraint(equalTo: menu.bottomAnchor, constant: 20),
            startGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setupGameLayout(with difficulty: String) {
        print(gameView.bounds.size)
        gameView.frame = view.frame.insetBy(dx: 0, dy: 100)
        var cards: [CardModel] = getCards(difficulty: difficulty)
        let coordinates: [CGRect] = getCoordinates(difficulty: difficulty)
        cards.shuffle()
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
                let height: CGFloat = gameView.frame.height / CGFloat(numberOfRows)
                let width: CGFloat = gameView.frame.width / CGFloat(numberOfColumns)
                let xPosition: CGFloat = CGFloat(column) * (gameView.frame.width / CGFloat(numberOfColumns))
                let yPosition: CGFloat = CGFloat(row) * (gameView.frame.height / CGFloat(numberOfRows))
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
            currentScore += 10
            if gameView.subviews.count == 2 {
                print("field is empty")
                if currentPlayer.highscore < currentScore {
                    currentPlayer.highscore = currentScore
                }
                let alertController = UIAlertController(title: "You won!", message: "Your score is: \(currentScore)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    self.dismiss(animated: true, completion: {
                        UIView.transition(from: self.gameView, to: self.view, duration: 0.3, options: .transitionCrossDissolve)
                        self.navigationController?.isNavigationBarHidden.toggle()})
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                currentScore = 0
            } else {
                print ("field is not empty")
                print(gameView.subviews.count)
            }
        } else {
            firstCard?.flip(completion: nil)
            secondCard?.flip(completion: nil)
            currentScore = Int16((Double(currentScore) * 0.9))
        }
        }
    func getCards(difficulty: String) -> [CardModel] {
        var cards: [CardModel] = []
        
        var backViews: [UIImage?] = [ UIImage(systemName: "cross.vial"),
                                      UIImage(systemName: "bolt.car"),
                                      UIImage(systemName: "pc"),
                                      UIImage(systemName: "stethoscope"),
                                      UIImage(systemName: "car.fill"),
                                      UIImage(systemName: "house.circle.fill"),
                                      UIImage(systemName: "cross.circle.fill"),
                                      UIImage(systemName: "airplane.circle.fill")]
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
    func getCoordinates(difficulty: String) -> [CGRect]{
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
