//
//  ProfileViewController.swift
//  testingtesting123
//
//  Created by Rohan Shankar on 12/3/24.
//


import UIKit

class ProfileViewController: UIViewController {
    var userProfile: UserProfile!

    private let nameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let ridesLabel = UILabel()
    private let gradYearLabel = UILabel()
    private let majorLabel = UILabel()
    private let bioLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = userProfile.name
        setupUI()
        displayProfile()
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, ratingLabel, ridesLabel, gradYearLabel, majorLabel, bioLabel])
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
    }

    private func displayProfile() {
        nameLabel.text = "Name: \(userProfile.name)"
        ratingLabel.text = "Rating: \(String(format: "%.1f", userProfile.rating))/5"
        ridesLabel.text = "Previous Rides: \(userProfile.numberOfRides)"
        gradYearLabel.text = "Graduation Year: \(userProfile.gradYear)"
        majorLabel.text = "Major: \(userProfile.major)"
        bioLabel.text = "Bio: \(userProfile.bio)"
    }
}
