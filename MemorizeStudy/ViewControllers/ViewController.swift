//
//  ViewController.swift
//  MemorizeStudy
//
//  Created by  on 24.05.25.
//

import UIKit

class ViewController: UITabBarController {
    
    var currentPlayer: User!
    let gameVC = GameViewController()
    let scoreBoardVC = ScoreBoardViewController()
    let aboutGameVC = AboutGameViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        gameVC.currentPlayer = currentPlayer
        navigationController?.navigationBar.isHidden = true
    }
    private func setupTabBar() {
        
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 20
        tabBar.layer.shadowOpacity = 0.5
        viewControllers = [generateVC(with: "About game", image: UIImage(systemName: "house")!, viewController: aboutGameVC),
                           generateVC(with: "Game", image: UIImage(systemName: "gamecontroller")!, viewController: gameVC),
                           generateVC(with: "Scoreboard", image: UIImage(systemName: "star")!, viewController: scoreBoardVC)
        ]
    }
    private func generateVC(with title: String, image: UIImage, viewController: UIViewController) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    override func viewDidLayoutSubviews() {
//        tabBar.invalidateIntrinsicContentSize()
//        var tabBarFrame = tabBar.frame
//        tabBarFrame.origin.y = 0
//        tabBar.frame = tabBarFrame
    }
    
}
