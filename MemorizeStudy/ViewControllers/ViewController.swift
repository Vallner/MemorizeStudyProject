//
//  ViewController.swift
//  MemorizeStudy
//
//  Created by  on 24.05.25.
//

import UIKit

class ViewController: UIViewController {

    var currentPlayer: User?
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var changePasswordTo123: UIButton = {
        let button = UIButton()
        button.setTitle("Change password to 123", for: .normal)
        button.backgroundColor = .systemBlue
        let action = UIAction{ _ in self.currentPlayer?.passsword = "123"}
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        // Do any additional setup after loading the view.
    }

    func setupLayout() {
        view.backgroundColor = .white
        nameLabel.text = currentPlayer?.nickName
        passwordLabel.text = currentPlayer?.passsword
        emailLabel.text = currentPlayer?.email
        view.addSubview(nameLabel)
        view.addSubview(passwordLabel)
        view.addSubview(emailLabel)
        view.addSubview(changePasswordTo123)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20),
            
            changePasswordTo123.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePasswordTo123.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            changePasswordTo123.widthAnchor.constraint(equalToConstant: 200),
            changePasswordTo123.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
