//
//  LoginViewController.swift
//  FPMI_App
//
//  Created by user on 13.05.26.
//  Kurdeko Egor

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let loginField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        loginField.placeholder = NSLocalizedString("login_placeholder", comment: "")
        loginField.borderStyle = .roundedRect
        loginField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = .roundedRect
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.setTitle(NSLocalizedString("login_btn", comment: ""), for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        view.addSubview(loginField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            loginField.widthAnchor.constraint(equalToConstant: 260),
            loginField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 15),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 260),
            passwordField.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 25),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func didTapLogin() {
        guard let login = loginField.text, !login.isEmpty,
              let pass = passwordField.text, !pass.isEmpty else {
            return
        }
    
        UserDefaults.standard.set(true, forKey: "isAuth")
        UserDefaults.standard.set(login, forKey: "currentUser") 
        
        let nav = UINavigationController(rootViewController: DepartmentsViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
