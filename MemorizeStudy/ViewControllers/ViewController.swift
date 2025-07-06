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
        tabBar.isHidden = true
        viewControllers = [ aboutGameVC, gameVC, scoreBoardVC ]
        let customTabBarButtons: [UIButton] = [
            generateTapBarButton(image: "house", tag: 0),
            generateTapBarButton(image: "gamecontroller", tag: 1),
            generateTapBarButton(image: "star", tag: 2)
        ]
        let customTabBarView = TabBarCustomView(frame: CGRect(x: 0, y:view.frame.height - 100,
                                                                width: view.frame.width, height: 50),
                                                                buttons: customTabBarButtons)
        view.addSubview(customTabBarView)
    }
    private func generateTapBarButton( image: String, tag: Int) -> UIButton {
        let action = UIAction{ _ in
            self.selectedIndex = tag
        }
        var button = UIButton(primaryAction: action)
        button.setImage(UIImage(systemName: image), for: .normal)
        return button
    }
    override func viewDidLayoutSubviews() {
//        tabBar.invalidateIntrinsicContentSize()
//        var tabBarFrame = tabBar.frame
//        tabBarFrame.origin.y = 0
//        tabBar.frame = tabBarFrame
    }
    
}
