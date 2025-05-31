//
//  RegisterViewController.swift
//  MemorizeStudy
//
//  Created by  on 28.05.25.
//

import UIKit

class RegisterViewController: UIViewController {

    private let dataManager = CoreDataManager.shared
    weak var delegate: LogInViewController!
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        let action: UIAction = UIAction { _ in
            if self.checkName(self.nickNameTextField.text) && self.checkEmail(self.emailTextField.text) {
                let newUser = User(context: self.dataManager.viewContext)
                newUser.email = self.emailTextField.text ?? ""
                newUser.highscore = 0
                newUser.nickName = self.nickNameTextField.text ?? ""
                newUser.passsword = self.passwordTextField.text ?? ""
//                self.dataManager.saveContext()
                self.delegate?.dataSource.append(newUser)
                let nextVC = ViewController()
                nextVC.currentPlayer = newUser
                print(nextVC.currentPlayer )
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let alert = UIAlertController(title: "Wrong Email format or nickname", message: "Check your input", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
            
        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
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
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
    }
    private func setupLayout(){
        view.addSubview(titleLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
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
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
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
    private func checkName(_ name : String? ) -> Bool{
        guard name != nil else { return false }
        return name!.allSatisfy{ ("a"..."z").contains($0) || ("A"..."Z").self.contains($0)
        
        }
        
    }
    private func checkEmail(_ email: String? ) -> Bool{
        guard email != nil else {  return false
        }
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
            let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
            return emailPredicate.evaluate(with: email)
               
    }
}
