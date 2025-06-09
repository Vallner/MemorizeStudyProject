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
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.font = UIFont(name: "NoteWorthy-Bold", size: 15)
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
        label.text = "Enter your account:"
        label.textAlignment = .center
        label.textColor = .white
        label.layer.shadowOpacity = 1
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.font = UIFont(name: "NoteWorthy-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Nickname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.font = UIFont(name: "NoteWorthy-Bold", size: 15)
        let action: UIAction = UIAction { _ in
            for user in self.dataSource {
                if user.nickName == self.nickNameTextField.text,
                   user.passsword == self.passwordTextField.text {
                    let nextVC = ViewController()
                    nextVC.currentPlayer = user
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    return
                }
            }
            print(self.dataSource)
            let alertController = UIAlertController(title: "Error",
                                                    message: "Wrong username or password",
                                                    preferredStyle: .alert)
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
        navigationItem.backButtonTitle = ""
        // Do any additional setup after loading the view.
    }
    private func setupLayout() {
        let separator = {
            let line = UIView()
            line.backgroundColor = .separator
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()
        let loginStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [nickNameTextField,passwordTextField])
            stackView.spacing = 10
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        view.addSubview(titleLabel)
        view.addSubview(loginStackView)
        view.addSubview(logInButton)
        view.addSubview(newUserButton)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            loginStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 20),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newUserButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor),
            newUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
