//
//  LogInViewController.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 26.05.25.
//

import UIKit

class LogInViewController: UIViewController {

    var dataSource: [User] = []
    private let dataManager = CoreDataManager.shared
    private lazy var newUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("New player?", for: .normal)
        let action: UIAction = .init { _ in
            let nextVC = RegisterViewController()
            nextVC.delegate = self
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nickname"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)

        let action: UIAction = UIAction { _ in
            for user in self.dataSource {
                if user.nickName == self.nickNameTextField.text,
                   user.passsword == self.passwordTextField.text {
                    let nextVC = ViewController()
                    nextVC.currentPlayer = user
                    print(nextVC.currentPlayer)
                    print(user)
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    return
                }
            }
            print(self.dataSource)
            let alertController = UIAlertController(title: "Error", message: "Wrong username or password", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
            
        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = dataManager.obtainData()
        setupLayout()
        self.navigationItem.backButtonTitle = "logout"
        // Do any additional setup after loading the view.
    }
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(passwordTextField)
        view.addSubview(nickNameTextField)
        view.addSubview(logInButton)
        view.addSubview(newUserButton)
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nickNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nickNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            
            passwordTextField.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            newUserButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor),
            newUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
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
