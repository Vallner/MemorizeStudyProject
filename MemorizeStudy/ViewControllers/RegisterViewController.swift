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
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.titleLabel?.font = UIFont(name: "NoteWorthy-Bold", size: 15)
        let action: UIAction = UIAction { _ in
            if self.delegate.dataSource.contains(where: { $0.email == self.emailTextField.text }) {
                let alert = UIAlertController(title: "This email is already in use",
                                              message: "Try to LogIn, or use another email",
                                              preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default))
                self.present(alert, animated: true)
    } else if self.checkName(self.nickNameTextField.text) && self.checkEmail(self.emailTextField.text)&&self.checkPassword(self.passwordTextField.text) {
                let newUser = User(context: self.dataManager.viewContext)
                newUser.email = self.emailTextField.text ?? ""
                newUser.highscore = 0
                newUser.nickName = self.nickNameTextField.text ?? ""
                newUser.passsword = self.passwordTextField.text ?? ""
//                self.dataManager.saveContext()
                self.delegate?.dataSource.append(newUser)
                CoreDataManager.shared.saveContext()
                let nextVC = ViewController()
                nextVC.currentPlayer = newUser
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let alert = UIAlertController(title: "Wrong Email format, nickname or password",
                                              message: """
                                                        Check your input, password should be at least 8 characters,
                                                        email should be in the format example@gmail.com
                                                       """,
                                              preferredStyle: .alert)
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
        label.textColor = .white
        label.layer.shadowOpacity = 1
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.font = UIFont(name: "NoteWorthy-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Nickname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
       
  
        // Do any additional setup after loading the view.
    }
    private func setupLayout() {
        let stackView = {
            let stackView  = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.addArrangedSubview(nickNameTextField)
            stackView.addArrangedSubview(emailTextField)
            stackView.addArrangedSubview(passwordTextField)
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            signUpButton.topAnchor.constraint(equalTo:stackView.bottomAnchor, constant: 20),
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
    private func checkPassword(_ password: String? ) -> Bool{
        guard password != nil else {  return false
        }
        return password!.count >= 8
    }
}
