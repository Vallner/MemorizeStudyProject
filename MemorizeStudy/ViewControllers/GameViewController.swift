//
//  GameViewController.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 28.05.25.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentPlayer: User!
    
    var cards: [CardModel] = [CardModel(frontImage: UIImage(systemName: "moon")!),
                              CardModel(frontImage: UIImage(systemName: "moon")!),
                              CardModel(frontImage: UIImage(systemName: "moon")!),
                              CardModel(frontImage: UIImage(systemName: "moon")!),
                              CardModel(frontImage: UIImage(systemName: "moon")!),
                              CardModel(frontImage: UIImage(systemName: "moon")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    func setupLayout() {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        for row in stride(from: 0, to: cards.count, by: 2) {
            let newRowOfCards = Array(cards[row..<min(row+2, cards.count)])
            let stackViewOfRow: UIStackView = UIStackView(arrangedSubviews: newRowOfCards)
            stackViewOfRow.axis = .horizontal
            stackViewOfRow.translatesAutoresizingMaskIntoConstraints = false
            stackViewOfRow.spacing = 20
            stackViewOfRow.distribution = .fillEqually
            stackView.addArrangedSubview(stackViewOfRow)
        }
        view.addSubview(stackView)
//        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
//    func setupCards(numberOfCards: Int){
//        let card = cards[0]
//        switch numberOfCards {
//        case 8:
//            let cards = Array(repeating: card, count: numberOfCards)
//            let stackView: UIStackView = UIStackView(arrangedSubviews: cards)
//            for card in cards {
//                card.frame.origin.x += card.frame.width + 20
//            }
//        case 12:
//            
//        case 16:
//            
//        default:
//            break
//        }
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
