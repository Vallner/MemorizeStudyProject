//
//  AboutGameViewController.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 28.05.25.
//

import UIKit

class AboutGameViewController: UIViewController {
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "How to play"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rulesLabel: UILabel = {
        let label = UILabel()
        label.text = """
                        To start game press start button. You will have limitted time to find all pairs of cards.
                        Try to find all pairs as fast as possible. You always can change game settings.
                     """
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(rulesLabel)
        setupLayout()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rulesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            rulesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rulesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//            rulesLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
