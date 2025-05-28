//
//  ViewController.swift
//  MemorizeStudy
//
//  Created by  on 24.05.25.
//

import UIKit

class ViewController: UITabBarController {
    
    weak var currentPlayer: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
        self.navigationItem.backButtonTitle = "logout"
        // Do any additional setup after loading the view.
    }
    
    private func setupTabBar() {
        
        tabBar.backgroundColor = .darkGray
      
        viewControllers = [generateVC(with: "About game", image: UIImage(systemName: "house")!, viewController: AboutGameViewController()),
                           generateVC(with: "Game", image: UIImage(systemName: "gamecontroller")!, viewController: GameViewController()),
                           generateVC(with: "Scoreboard", image: UIImage(systemName: "star")!, viewController: ScoreBoardViewController())
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
