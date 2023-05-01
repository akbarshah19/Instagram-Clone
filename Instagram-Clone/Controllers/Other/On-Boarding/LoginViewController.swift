//
//  LoginViewController.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 4/30/23.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter username or email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Enter password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account? Register", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let instaLabel: UILabel = {
        let label = UILabel()
        label.text = "Instagram"
        label.textAlignment = .center
        label.font = UIFont(name: "Cookie-Regular", size: 60)
        label.textColor = .label
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        logo.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 100, width: view.width/5, height: view.width/5)
        logo.center.x = view.center.x
        instaLabel.frame = CGRect(x: 20, y: logo.bottom, width: view.width - 40, height: 70)
        usernameEmailField.frame = CGRect(x: 20, y: instaLabel.bottom + 60, width: view.width - 40, height: 45)
        passwordField.frame = CGRect(x: 20, y: usernameEmailField.bottom + 10, width: view.width - 40, height: 45)
        loginButton.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width - 40, height: 45)
        registerButton.frame = CGRect(x: 20, y: loginButton.bottom + 10, width: view.width - 40, height: 35)
        termsButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 50, width: view.width - 20, height: 25)
        privacyButton.frame = CGRect(x: 10, y: termsButton.bottom, width: view.width - 20, height: 25)
    }
    
    private func addSubviews() {
        view.addSubview(logo)
        view.addSubview(instaLabel)
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    @objc func didTapLoginButton() {
        usernameEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            print("Error: Invalid username/email or passoword.")
            return
        }
        
        var email: String?
        var username: String?
        
        if usernameEmail.contains("@") && usernameEmail.contains(".") {
            email = usernameEmail
        } else {
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    //logged in
                    self.dismiss(animated: true)
                } else {
                    //error occured
                    let alert = UIAlertController(title: "Unable to log in",
                                                  message: "Something went wrong. Please try again later.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func didTapRegisterButton() {
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.title = "Register"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc func didTapTermsButton() {
        guard let url = URL(string:  "https://help.instagram.com/581066165581870") else {
            print("Error: Terms url.")
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapPrivacyButton() {
        guard let url = URL(string:  "https://privacycenter.instagram.com/policy") else {
            print("Error: Privacy url is empty.")
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            
        } else if textField == passwordField {
            
        }
        return true
    }
}
