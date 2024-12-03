//
//  RideListingsViewController.swift
//  testingtesting123
//
//  Created by Rohan Shankar on 12/3/24.
//

import UIKit

class RideListingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()
    var currentUserProfile: UserProfile!
    private var listings: [RideListing] = [
        RideListing(driver: "Alex", price: "$10", members: ["Sam", "Jordan"], location: "North Campus"),
        RideListing(driver: "Taylor", price: "$15", members: ["Chris", "Robin"], location: "Central Campus"),
        RideListing(driver: "Jordan", price: "$12", members: ["Alex", "Taylor"], location: "West Campus"),
        RideListing(driver: "Morgan", price: "$8", members: ["Jamie", "Riley"], location: "East Campus"),
        RideListing(driver: "Casey", price: "$20", members: ["Taylor", "Morgan", "Jordan"], location: "Collegetown"),
        RideListing(driver: "Chris", price: "$18", members: ["Robin"], location: "Downtown Ithaca"),
        RideListing(driver: "Riley", price: "$7", members: ["Sam"], location: "South Campus"),
        RideListing(driver: "Jamie", price: "$25", members: ["Casey", "Morgan"], location: "Ithaca Commons")
    ]
    
    let userProfiles: [String: UserProfile] = [
        "Alex": UserProfile(name: "Alex", rating: 4.8, numberOfRides: 25, gradYear: 2025, major: "Computer Science", bio: "Enjoys long drives and coffee."),
        "Taylor": UserProfile(name: "Taylor", rating: 4.6, numberOfRides: 18, gradYear: 2024, major: "Mechanical Engineering", bio: "Friendly and reliable driver."),
        "Jordan": UserProfile(name: "Jordan", rating: 4.7, numberOfRides: 15, gradYear: 2026, major: "Biology", bio: "Loves nature and outdoor adventures."),
        "Sophia": UserProfile(name: "Sophia", rating: 5.0, numberOfRides: 30, gradYear: 2024, major: "Economics", bio: "Always punctual and organized.")
    ]



    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ride Listings"
        view.backgroundColor = .white

        setupTableView()
        setupProfileButton()
    }

    private func setupProfileButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Profile",
            style: .plain,
            target: self,
            action: #selector(viewProfile)
        )
    }

    


    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RideListingCell.self, forCellReuseIdentifier: RideListingCell.identifier)
        tableView.separatorStyle = .none // Remove default separators
        tableView.backgroundColor = UIColor.white
        tableView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0) // Add space around the entire list
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }

    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust this for more spacing
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RideListingCell.identifier, for: indexPath) as! RideListingCell
        let listing = listings[indexPath.row]
        cell.configure(with: listing)
        
        // Highlight cells for groups the user is part of
        cell.contentView.backgroundColor = listing.userIsMember ? UIColor(red: 0.9, green: 0.95, blue: 1.0, alpha: 1.0) : .white
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedListing = listings[indexPath.row]
        let detailVC = RideDetailViewController()
        detailVC.rideListing = selectedListing

        detailVC.onMembershipChange = { [weak self] updatedListing in
            guard let self = self else { return }
            self.listings[indexPath.row] = updatedListing
            self.sortAndReloadData()
        }

        navigationController?.pushViewController(detailVC, animated: true)
    }

    private func sortAndReloadData() {
        listings.sort { $0.userIsMember && !$1.userIsMember } // Sort groups with user membership at the top
        tableView.reloadData()
    }
    
    @objc private func viewProfile() {
        let profileVC = ProfileViewController()
        profileVC.userProfile = currentUserProfile
        navigationController?.pushViewController(profileVC, animated: true)
    }


}
