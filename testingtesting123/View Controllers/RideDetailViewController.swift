

import UIKit

class RideDetailViewController: UIViewController {
    var rideListing: RideListing!
    //var onMembershipChange: ((RideListing) -> Void)?
    var onMembershipChange: ((RideListing, UserProfile) -> Void)?

    var userProfile: UserProfile!
    
    var userProfiles: [String: UserProfile] = [
        "Alex": UserProfile(name: "Alex", username: "alex236", password: "hello", money: 100),
        "Taylor": UserProfile(name: "Taylor", username: "taylor112", password: "test", money: 100),
        "Jordan": UserProfile(name: "Jordan", username: "jordan93", password: "bye", money: 100),
        "Sophia": UserProfile(name: "Sophia", username: "soph212", password: "notstrong", money: 100)
    ]
    
    private let driverLabel = UILabel()
    private let priceLabel = UILabel()
    private let destinationLabel = UILabel()
    private let dateLabel = UILabel()
    private let ridersLabel = UILabel()
    private let infoLabel = UILabel()
    private let mainLabel = UILabel()
    private let joinLeaveButton = UIButton()
    private let circleImage = UIImageView()
    private let stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        setupCircleImage()
        setupMainLabel()
        setupInfoLabel()
        setupUI()
        setupJoinLeaveButton()
        updateUI()
    }
    
    private func setupUI() {
        driverLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(driverTapped))
        driverLabel.addGestureRecognizer(tapGesture)
        
        ridersLabel.isUserInteractionEnabled = true
        
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.hack.silver
        stackView.layer.cornerRadius = 15
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // Set padding as desired
        stackView.isLayoutMarginsRelativeArrangement = true // Enable layoutMargins for arranged subviews
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(driverLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(destinationLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(ridersLabel)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalToConstant: 350),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
            
        driverLabel.textColor = .black
        priceLabel.textColor = .black
        destinationLabel.textColor = .black
        ridersLabel.textColor = .black
    }
    
    private func updateUI() {
        driverLabel.text = "Driver: \(rideListing.drivers)"
        priceLabel.text = "Price: \(rideListing.gas_price)"
        destinationLabel.text = "Destination: \(rideListing.destination)"
        dateLabel.text = "Date: \(rideListing.date)"
        ridersLabel.text = "Riders: \(rideListing.riders.joined(separator: ", "))"
        
        print("THE USER IS MEMBER: \(rideListing.userIsMember)")
        let buttonTitle = rideListing.userIsMember ? "Leave Group" : "Join Group"
        if rideListing.userIsMember{
            joinLeaveButton.backgroundColor = UIColor.hack.ruby
        }
        else {
            joinLeaveButton.backgroundColor = UIColor.hack.green
        }
                
        joinLeaveButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func setupJoinLeaveButton() {
        joinLeaveButton.backgroundColor = UIColor.hack.green
        joinLeaveButton.setTitleColor(.white, for: .normal)
        joinLeaveButton.layer.cornerRadius = 20
        joinLeaveButton.addTarget(self, action: #selector(joinLeaveButtonTapped), for: .touchUpInside)
        
        view.addSubview(joinLeaveButton)
        joinLeaveButton.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            joinLeaveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            joinLeaveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinLeaveButton.widthAnchor.constraint(equalToConstant: 350),
            joinLeaveButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setupCircleImage() {
        circleImage.image = UIImage(named: "circle1")
        circleImage.contentMode = .scaleAspectFill  // Ensures the image fills the bounds while preserving aspect ratio
        
        view.addSubview(circleImage)
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleImage.topAnchor.constraint(equalTo: view.topAnchor),
            circleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            circleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupMainLabel() {
        mainLabel.text = "Have a safe trip!"
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
    
    private func setupInfoLabel() {
        infoLabel.text = "Ride Information"
        infoLabel.textColor = UIColor.black
        infoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: circleImage.bottomAnchor, constant: 50),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func driverTapped() {
        guard let profile = userProfiles[rideListing.drivers] else { return }
        navigateToProfile(profile)
    }

    @objc private func joinLeaveButtonTapped() {
        // Ensure we have the current user's profile
        print("CURRENTUSER: " , userProfile.name)

        var currentUserProfile = userProfile!
        print(currentUserProfile.money)
        print(currentUserProfile.name)

        let listingPrice = Int(rideListing.gas_price.trimmingCharacters(in: ["$"])) ?? 0

        // If the user is the driver, no money changes
        if rideListing.drivers != currentUserProfile.name {
            if rideListing.userIsMember {
                // Refund money when leaving
                currentUserProfile.money += listingPrice
                print(currentUserProfile.money)
            } else {
                // Check if the user has enough money to join
                if currentUserProfile.money >= listingPrice {
                    currentUserProfile.money -= listingPrice
                    print(currentUserProfile.money)
                } else {
                    // Show alert if not enough money
                    let alert = UIAlertController(
                        title: "Insufficient Funds",
                        message: "You do not have enough money to join this group.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            }
        }

        // Update the user profiles dictionary
        userProfiles[currentUserProfile.name] = currentUserProfile

        // Toggle membership and update UI
        rideListing.toggleMembership()
        updateUI()

        // Pass back the updated profile through the callback
        onMembershipChange?(rideListing, currentUserProfile)
    }

    
    private func navigateToProfile(_ profile: UserProfile) {
        let profileVC = ProfileViewController()
        profileVC.userProfile = profile
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

