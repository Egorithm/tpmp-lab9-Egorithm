//
//  ViewController.swift
//  example1_2
//
//  Created by user on 13.05.26.
//  Kurdeko Egor

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var authSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var termsSwitch: UISwitch!
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Properties
    let userDefaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkLoginStatus()
    }

    // MARK: - UI Setup
    private func setupUI() {
        emailTextField.isHidden = true
        actionButton.setTitle("Войти", for: .normal)
    }

    // MARK: - IBActions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        let isLogin = sender.selectedSegmentIndex == 0
        emailTextField.isHidden = isLogin
        actionButton.setTitle(isLogin ? "Войти" : "Зарегистрироваться", for: .normal)
    }

    @IBAction func actionButtonTapped(_ sender: UIButton) {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Ошибка: Заполните поля")
            return
        }

        if authSegmentedControl.selectedSegmentIndex == 0 {
            loginUser(login: login, pass: password)
        } else {
            registerUser(login: login, pass: password)
        }
    }

    // MARK: - Business Logic (UserDefaults)
    private func loginUser(login: String, pass: String) {
        let savedLogin = userDefaults.string(forKey: "userLogin")
        if login == savedLogin {
            userDefaults.set(true, forKey: "isLoggedIn")
            print("Успешный вход!")
        }
    }

    private func checkLoginStatus() {
        if userDefaults.bool(forKey: "isLoggedIn") {
            print("Пользователь уже в системе")
        }
    }

    // MARK: - Business Logic (.plist)
    private func registerUser(login: String, pass: String) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let documentsDirectory = paths.first {
            let fileURL = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("UserData.plist")
            
            let data: [String: String] = ["login": login, "password": pass]
            (data as NSDictionary).write(to: fileURL, atomically: true)
            
            userDefaults.set(login, forKey: "userLogin")
            print("Данные сохранены в .plist по пути: \(fileURL)")
        }
    }
}

