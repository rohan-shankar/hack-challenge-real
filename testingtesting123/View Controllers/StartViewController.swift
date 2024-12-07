//
//  StartViewController.swift
//  testingtesting123
//
//  Created by Rohan Shankar on 12/3/24.
//

import UIKit

class StartViewController: UIViewController {
    private let logoImageView = UIImageView()
    private let appTitle1 = UILabel()
    private let appTitle2 = UILabel()
    private let nameTextField = UITextField()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let moneyTextField = UITextField()
    private let stackView = UIStackView()
    private let createProfileButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLogoImageView()
        setupAppTitle1()
        setupAppTitle2()
        setupUI()
        setupProfileButton()
    }
    private func setupLogoImageView() {
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 90),
            logoImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupAppTitle1() {
        appTitle1.text = "Welcome to"
        appTitle1.font = .systemFont(ofSize: 40, weight: .semibold)
        appTitle1.textColor = .black
        
        view.addSubview(appTitle1)
        appTitle1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appTitle1.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            appTitle1.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupAppTitle2() {
        appTitle2.text = "BigRedRides!"
        appTitle2.font = .systemFont(ofSize: 40, weight: .semibold)
        appTitle2.textColor = UIColor.hack.ruby
        
        view.addSubview(appTitle2)
        appTitle2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appTitle2.topAnchor.constraint(equalTo: appTitle1.bottomAnchor),
            appTitle2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupUI() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(moneyTextField)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalToConstant: 350)
        ])

        // Configure text fields
        configureTextField(nameTextField, placeholder: "Enter your name")
        configureTextField(usernameTextField, placeholder: "Enter your username")
        configureTextField(passwordTextField, placeholder: "Enter your password")
        configureTextField(moneyTextField, placeholder: "Enter your current balance ($)")
        moneyTextField.keyboardType = .numberPad // Ensure numeric input for money
    }

    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
    }
    
    private func setupProfileButton() {
        // Configure button
        createProfileButton.setTitle("Create Profile", for: .normal)
        createProfileButton.backgroundColor = UIColor.hack.ruby
        createProfileButton.setTitleColor(.white, for: .normal)
        createProfileButton.layer.cornerRadius = 20
        createProfileButton.addTarget(self, action: #selector(createProfileButtonTapped), for: .touchUpInside)
        
        view.addSubview(createProfileButton)
        createProfileButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createProfileButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            createProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createProfileButton.widthAnchor.constraint(equalToConstant: 350),
            createProfileButton.heightAnchor.constraint(equalToConstant: 45)])
    }

    @objc private func createProfileButtonTapped() {
        guard
            let name = nameTextField.text, !name.isEmpty,
            let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let moneyText = moneyTextField.text, let money = Int(moneyText), money >= 0
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill out all fields correctly.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        // Save user profile
        let userProfile = UserProfile(name: name, username: username, password: password, money: money)
        print("Assigning " , money)
        
        UserDefaults.standard.set(userProfile.username, forKey: "UserName")
        UserDefaults.standard.set(userProfile.password, forKey: "Password")

        let rideListingsVC = RideListingsViewController()
        rideListingsVC.currentUserProfile = userProfile

        navigationController?.setViewControllers([rideListingsVC], animated: true)
    }
}
