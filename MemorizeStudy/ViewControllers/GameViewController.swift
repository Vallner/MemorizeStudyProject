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
    var gameView:UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    var cards: [CardModel] = [CardModel(frontImage: UIImage(systemName: "moon")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),
                              CardModel(frontImage: UIImage(systemName: "star")!),
                              CardModel(frontImage: UIImage(systemName: "moon")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),
                              CardModel(frontImage: UIImage(systemName: "star")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        cards.shuffle()
        setupLayout()
        
    }

    func setupLayout() {
        print(gameView.bounds.size)
        gameView.frame = view.frame.insetBy(dx: 0, dy: 100)
        
        view.addSubview(gameView)
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        let coordinates = getPointsForCards(numberOfRows: 4, numberOfColumns: 3)
        for card  in cards {
            card.bounds.size = CGSize(width: 150, height: 150)
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
        } else {
            firstCard?.flip(completion: nil)
            secondCard?.flip(completion: nil)
        }
        }
}
