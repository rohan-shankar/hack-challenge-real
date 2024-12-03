//
//  RideDetailViewController.swift
//  testingtesting123
//
//  Created by Rohan Shankar on 12/3/24.
//
import UIKit

class RideDetailViewController: UIViewController {
    var rideListing: RideListing!
    var onMembershipChange: ((RideListing) -> Void)?
    
    let userProfiles: [String: UserProfile] = [
        "Alex": UserProfile(name: "Alex", rating: 4.8, numberOfRides: 25, gradYear: 2025, major: "Computer Science", bio: "Enjoys long drives and coffee."),
        "Taylor": UserProfile(name: "Taylor", rating: 4.6, numberOfRides: 18, gradYear: 2024, major: "Mechanical Engineering", bio: "Friendly and reliable driver."),
        "Jordan": UserProfile(name: "Jordan", rating: 4.7, numberOfRides: 15, gradYear: 2026, major: "Biology", bio: "Loves nature and outdoor adventures."),
        "Sophia": UserProfile(name: "Sophia", rating: 5.0, numberOfRides: 30, gradYear: 2024, major: "Economics", bio: "Always punctual and organized.")
    ]

    private let driverLabel = UILabel()
    private let priceLabel = UILabel()
    private let locationLabel = UILabel()
    private let membersLabel = UILabel()
    private let joinLeaveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        updateUI()
    }

    private func setupUI() {
        
        driverLabel.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(driverTapped))
            driverLabel.addGestureRecognizer(tapGesture)
        
        let stackView = UIStackView(arrangedSubviews: [driverLabel, priceLabel, locationLabel, membersLabel, joinLeaveButton])
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

        // Button setup
        joinLeaveButton.backgroundColor = .systemBlue
        joinLeaveButton.setTitleColor(.white, for: .normal)
        joinLeaveButton.layer.cornerRadius = 8
        joinLeaveButton.addTarget(self, action: #selector(joinLeaveButtonTapped), for: .touchUpInside)

        driverLabel.textColor = .black
        priceLabel.textColor = .black
        locationLabel.textColor = .black
        membersLabel.textColor = .black
    }
    
    @objc private func driverTapped() {
        guard let profile = userProfiles[rideListing.driver] else { return }
        let profileVC = ProfileViewController()
        profileVC.userProfile = profile
        navigationController?.pushViewController(profileVC, animated: true)
    }

    private func updateUI() {
        driverLabel.text = "Driver: \(rideListing.driver)"
        priceLabel.text = "Price: \(rideListing.price)"
        locationLabel.text = "Location: \(rideListing.location)"
        membersLabel.text = "Members: \(rideListing.members.joined(separator: ", "))"

        let buttonTitle = rideListing.userIsMember ? "Leave Group" : "Join Group"
        joinLeaveButton.setTitle(buttonTitle, for: .normal)
    }

    @objc private func joinLeaveButtonTapped() {
        rideListing.userIsMember.toggle()
        if rideListing.userIsMember {
            rideListing.members.append("Whateveryournameis")
        } else {
            rideListing.members.removeAll { $0 == "Whateveryournameis" }
        }
        updateUI()
        onMembershipChange?(rideListing)
    }
}
