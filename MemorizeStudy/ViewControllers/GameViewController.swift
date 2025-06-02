//
//  GameViewController.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 28.05.25.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentPlayer: User!
    var gameView:UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }()
    var cards: [CardModel] = [CardModel(frontImage: UIImage(systemName: "moon")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),
                              CardModel(frontImage: UIImage(systemName: "star")!),
                              CardModel(frontImage: UIImage(systemName: "moon")!),
                              CardModel(frontImage: UIImage(systemName: "cross")!),
                              CardModel(frontImage: UIImage(systemName: "star")!)]
    
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
            gameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            ])
        let coordinates = getPointsForCards(numberOfRows: 3, numberOfColumns: 2)
        for card  in cards {
            card.frame.origin = coordinates[cards.firstIndex(of: card)!]
            gameView.addSubview(card)
        }
    }
    func getPointsForCards(numberOfRows: Int, numberOfColumns: Int) -> [CGPoint] {
        var coordinates: [CGPoint] = []
        for row in 0..<numberOfRows {
            for column in 0..<numberOfColumns {
                let xPosition: CGFloat = CGFloat(column) * (gameView.frame.width / CGFloat(numberOfColumns))
                let yPosition: CGFloat = CGFloat(row) * (gameView.frame.height / CGFloat(numberOfRows))
                coordinates.append(CGPoint(x: xPosition, y: yPosition))
        }
    }
    print(coordinates)
    return coordinates
    }
}
