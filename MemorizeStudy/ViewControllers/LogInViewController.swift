//
//  LogInViewController.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 26.05.25.
//

import UIKit

class LogInViewController: UIViewController {

    var dataSource: [User] = []
    let dataManager = CoreDataManager.shared
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nickname"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)

        let action: UIAction = UIAction { _ in
            for user in self.dataSource {
                if (user.nickName == self.nickNameTextField.text) && (user.passsword == self.passwordTextField.text) {
                    let nextVC = ViewController()
                    nextVC.currentPlayer = user
                    self.present(nextVC, animated: true)
                }
            }
        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        let action: UIAction = UIAction { _ in
            let newUser = User(context: self.dataManager.viewContext)
            newUser.email = self.emailTextField.text ?? ""
            newUser.highscore = 0
            newUser.nickName = self.nickNameTextField.text ?? ""
            newUser.passsword = self.passwordTextField.text ?? ""
            self.dataManager.saveContext()
            self.dataSource.append(newUser)
            let nextVC = ViewController()
            nextVC.currentPlayer = newUser
            self.present(nextVC, animated: true)
            print(self.dataSource)
        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = dataManager.obtainData()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(signUpButton)
        view.addSubview(nickNameTextField)
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nickNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nickNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
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
