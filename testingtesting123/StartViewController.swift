//
//  StartViewController.swift
//  testingtesting123
//
//  Created by Rohan Shankar on 12/3/24.
//


import UIKit

class StartViewController: UIViewController {
    private let nameTextField = UITextField()
    private let gradYearTextField = UITextField()
    private let majorTextField = UITextField()
    private let bioTextField = UITextField()
    private let createProfileButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create Profile"
        setupUI()
    }
    

    private func setupUI() {
        
        //this order can change -- the fields themself can also change since idt anybody cares about your major
        let stackView = UIStackView(arrangedSubviews: [nameTextField, gradYearTextField, majorTextField, bioTextField, createProfileButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        // Configure text fields
        configureTextField(nameTextField, placeholder: "Enter your name")
        configureTextField(gradYearTextField, placeholder: "Enter your graduation year")
        configureTextField(majorTextField, placeholder: "Enter your major")
        configureTextField(bioTextField, placeholder: "Enter a short bio")

        // Configure button
        createProfileButton.setTitle("Create Profile", for: .normal)
        createProfileButton.backgroundColor = .systemBlue
        createProfileButton.setTitleColor(.white, for: .normal)
        createProfileButton.layer.cornerRadius = 8
        createProfileButton.addTarget(self, action: #selector(createProfileButtonTapped), for: .touchUpInside)
    }

    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
    }

    @objc private func createProfileButtonTapped() {
        guard
            let name = nameTextField.text, !name.isEmpty,
            let gradYear = gradYearTextField.text, !gradYear.isEmpty,
            let major = majorTextField.text, !major.isEmpty,
            let bio = bioTextField.text, !bio.isEmpty
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill out all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        // Save user profile
        let userProfile = UserProfile(name: name, rating: 4.5, numberOfRides: 0, gradYear: Int(gradYear) ?? 2028, major: major, bio: bio)
        
        
        //rn 2028 is the default year but we could change that idk
        //more of a placeholder for now
        let rideListingsVC = RideListingsViewController()
        rideListingsVC.currentUserProfile = userProfile

        navigationController?.setViewControllers([rideListingsVC], animated: true)
    }
}
