
//
//  RideListingsViewController.swift
//  testingtesting123
//
//  Created by Rohan Shankar on 12/3/24.
//

import UIKit

class RideListingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let mainLabel = UILabel()
    private let tableView = UITableView()
    
    var currentUserProfile: UserProfile!

    static var listings: [RideListing] = [
        RideListing(id: 1230, destination: "North Campus", date: "10/27/2024", gas_price: "$10", drivers: "Alex", riders: ["Sam", "Jordan"]),
        RideListing(id: 1400, destination: "Central Campus", date: "10/27/2024", gas_price: "$15", drivers: "Taylor", riders: ["Chris", "Robin"]),
        RideListing(id: 90120, destination: "West Campus", date: "10/27/2024", gas_price: "$12", drivers: "Jordan", riders: ["Alex", "Taylor"]),
        RideListing(id: 1595, destination: "East Campus", date: "10/27/2024", gas_price: "$8", drivers: "Morgan", riders: ["Jamie", "Riley"]),
        RideListing(id: 1234, destination: "Collegetown", date: "10/27/2024", gas_price: "$20", drivers: "Casey", riders: ["Taylor", "Morgan", "Jordan"]),
        RideListing(id: 500, destination: "Downtown Ithaca", date: "10/27/2024", gas_price: "$18", drivers: "Chris", riders: ["Robin"]),
        RideListing(id: 8080, destination: "South Campus", date: "10/27/2024", gas_price: "$7", drivers: "Riley", riders: ["Sam"]),
        RideListing(id: 123409, destination: "Ithaca Commons", date: "10/27/2024", gas_price: "$25", drivers: "Jamie", riders: ["Casey", "Morgan"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.hack.ruby
//        navigationController?.navigationBar.tintColor = .white
        
        setupMainLabel()
        setupTableView()
        setupProfileButton()
        setupNewListingButton()
        sortAndReloadData()
    }
    private func setupMainLabel() {
        mainLabel.text = "Join a ride!"
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

    private func setupProfileButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Profile",
            style: .plain,
            target: self,
            action: #selector(viewProfile)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.hack.white
    }

    @objc private func makeListing() {
        let listingVC = ListingViewController()
        listingVC.userProfile = currentUserProfile
        listingVC.delegate = self
        navigationController?.pushViewController(listingVC, animated: true)
    }

    private func setupNewListingButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "New Listing",
            style: .plain,
            target: self,
            action: #selector(makeListing)
        )
        navigationItem.leftBarButtonItem?.tintColor = UIColor.hack.white
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RideListingCell.self, forCellReuseIdentifier: RideListingCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear  // Ensure the table view background is clear
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 32, right: 0)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RideListingsViewController.listings.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RideListingCell.identifier, for: indexPath) as! RideListingCell
        let listing = RideListingsViewController.listings[indexPath.row]
        cell.configure(with: listing)

        if listing.drivers == currentUserProfile.name {
            cell.contentView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 1.0, alpha: 1.0) // Light blue for driver
            
        } else if listing.userIsMember {
            cell.contentView.backgroundColor = UIColor(red: 0.9, green: 1.0, blue: 0.9, alpha: 1.0) // Light green
        } else if let listingPrice = Int(listing.gas_price.trimmingCharacters(in: ["$"])),
                  listingPrice > currentUserProfile.money {
            cell.contentView.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0) // Light red for too expensive
        } else {
            cell.contentView.backgroundColor = UIColor.hack.silver
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedListing = RideListingsViewController.listings[indexPath.row]
        let detailVC = RideDetailViewController()
        detailVC.rideListing = selectedListing
        detailVC.userProfile = currentUserProfile

        /**detailVC.onMembershipChange = { [weak self] updatedListing in
            guard let self = self else { return }
            self.listings[indexPath.row] = updatedListing
            self.sortAndReloadData()
        }*/
        
        detailVC.onMembershipChange = { [weak self] updatedListing, updatedProfile in
            guard let self = self else { return }

            // Update the ride listing
            RideListingsViewController.listings[indexPath.row] = updatedListing

            // Update the current user profile with the updated profile
            self.currentUserProfile = updatedProfile

            // Reload the table to reflect the updated data
            self.sortAndReloadData()
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    /**@objc private func viewProfile() {
        let profileVC = ProfileViewController()
        profileVC.userProfile = currentUserProfile
        navigationController?.pushViewController(profileVC, animated: true)
    }*/
    
    @objc func viewProfile() {
            let profileVC = ProfileViewController()
            profileVC.userProfile = currentUserProfile
            profileVC.onBalanceUpdated = { [weak self] updatedProfile in
                self?.currentUserProfile = updatedProfile  // Update the current user profile
                print(updatedProfile.money)
                print(updatedProfile.name)
                self?.sortAndReloadData()
            }

            navigationController?.pushViewController(profileVC, animated: true)
        }

    private func sortAndReloadData() {
        sortListings()
        removeEmptyListings()
        tableView.reloadData()
    }

    func sortListings() {
        let userName = currentUserProfile.name
        RideListing.currentUserName = userName
        RideListingsViewController.listings.sort { first, second in
            if first.drivers == userName && second.drivers != userName {
                return true
            } else if first.drivers != userName && second.drivers == userName {
                return false
            }
            return first.userIsMember && !second.userIsMember
        }
    }

    private func removeEmptyListings() {
        RideListingsViewController.listings.removeAll { $0.riders.isEmpty }
    }
}

// MARK: - Extensions
extension RideListingsViewController: ListingViewControllerDelegate {
    func didPostNewListing(_ listing: RideListing) {
        RideListingsViewController.listings.append(listing)
        sortAndReloadData()
    }
}

protocol ListingViewControllerDelegate: AnyObject {
    func didPostNewListing(_ listing: RideListing)
}
