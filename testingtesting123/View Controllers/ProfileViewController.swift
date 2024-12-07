//
//  ProfileViewController.swift
//  testingtesting123
//
//  Created by Rohan Shankar on 12/3/24.
//

import UIKit

class ProfileViewController: UIViewController {
    var userProfile: UserProfile!
    var onBalanceUpdated: ((UserProfile) -> Void)?  // Callback to notify of balance update

    //MARK: - Properties (view)
    private let mainLabel = UILabel()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let moneyLabel = UILabel() // New label for money
    private let addMoneyButton = UIButton() // Button to add money
    private let stackView = UIStackView()
    private let whiteCircle = UIImageView()

    //MARK: - Properties (data)
    let savedUserName = UserDefaults.standard.string(forKey: "UserName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = UIColor.hack.ruby
        setupMainLabel()
        setupWhiteCircle()
        setupUI()
        setupAddMoneyButton()
        displayProfile()
    }
    
    private func setupMainLabel() {
        if savedUserName != userProfile.username {
            mainLabel.text = ("Profile View:")
        }
        else {
            mainLabel.text = ("Your Profile:")
        }
        mainLabel.textColor = UIColor.white
        mainLabel.font = .systemFont(ofSize: 40, weight: .semibold)
        
        view.addSubview(mainLabel)
        view.bringSubviewToFront(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupUI() {
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.hack.silver
        stackView.layer.cornerRadius = 15
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // Set padding as desired
        stackView.isLayoutMarginsRelativeArrangement = true // Enable layoutMargins for arranged subviews
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(moneyLabel)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 150),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 350),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupWhiteCircle() {
        whiteCircle.image = UIImage(named: "white")
        whiteCircle.contentMode = .scaleAspectFill  // Ensures the image fills the bounds while preserving aspect ratio
        
        view.addSubview(whiteCircle)
        whiteCircle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whiteCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteCircle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteCircle.heightAnchor.constraint(equalToConstant: 650)
        ])
    }

    private func displayProfile() {
        nameLabel.text = "Name: \(userProfile.name)"
        usernameLabel.text = "Username: \(userProfile.username)"
        moneyLabel.text = "Balance: $\(userProfile.money)" // Display money
    }
    
    private func setupAddMoneyButton() {
        // Configure the addMoneyButton
        addMoneyButton.setTitle("Add $10", for: .normal)
        addMoneyButton.backgroundColor = .systemGreen
        addMoneyButton.layer.cornerRadius = 20
        addMoneyButton.addTarget(self, action: #selector(addMoneyButtonTapped), for: .touchUpInside)
        
        view.addSubview(addMoneyButton)
        addMoneyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addMoneyButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            addMoneyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addMoneyButton.widthAnchor.constraint(equalToConstant: 350),
            addMoneyButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        if savedUserName != userProfile.username {
            addMoneyButton.isHidden = true // Hide the button if names don't match\
            moneyLabel.isHidden = true
        }
    }

    @objc private func addMoneyButtonTapped() {
        userProfile.money += 10 // Add $10 to the user's balance
        moneyLabel.text = "Balance: $\(userProfile.money)" // Update the label

        // Notify the main view (or parent controller) of the updated profile
        onBalanceUpdated?(userProfile)
    }
}




