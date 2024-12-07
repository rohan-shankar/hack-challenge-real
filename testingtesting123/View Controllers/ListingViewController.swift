//
//  ListingViewController.swift
//  testingtesting123
//
//  Created by Krystal Kymn on 12/3/24.
//
import UIKit

class ListingViewController: UIViewController {
    var userProfile: UserProfile!
    private let priceTextField = UITextField()
    private let destinationTextField = UITextField()
    private let dateTextField = UITextField()
    private let postListingButton = UIButton()
    private let carImage = UIImageView()
    private let circleImage = UIImageView()
    private let mainLabel = UILabel()
    
    weak var delegate: ListingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCircleImage()
        setupMainLabel()
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [carImage, priceTextField, destinationTextField, dateTextField, postListingButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 450),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        setupCarImageView()

        // Configure text fields
        configureTextField(priceTextField, placeholder: "Enter the numerical price ($)")
        configureTextField(destinationTextField, placeholder: "Enter your destination")
        configureTextField(dateTextField, placeholder: "Enter the date in MM/DD/YYYY")

        // Configure button
        setupListingButton()
    }
    private func setupCircleImage() {
        circleImage.image = UIImage(named: "circle1")
        circleImage.contentMode = .scaleAspectFill  // Ensures the image fills the bounds while preserving aspect ratio
        
        view.addSubview(circleImage)
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleImage.topAnchor.constraint(equalTo: view.topAnchor),
            circleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            circleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupMainLabel() {
        mainLabel.text = ("Post a ride!")
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
    
    private func setupCarImageView() {
        carImage.image = UIImage(named: "car")
        
        NSLayoutConstraint.activate([
            carImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            carImage.widthAnchor.constraint(equalToConstant: 300),
            carImage.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 20
        textField.textAlignment = .center
        
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 288),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupListingButton() {
        postListingButton.setTitle("Post Listing", for: .normal)
        postListingButton.backgroundColor = UIColor.hack.ruby
        postListingButton.setTitleColor(.white, for: .normal)
        postListingButton.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            postListingButton.widthAnchor.constraint(equalToConstant: 288),
            postListingButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        postListingButton.addTarget(self, action: #selector(postListingButtonTapped), for: .touchUpInside)
    }

    @objc private func postListingButtonTapped() {
        guard
            let destination = destinationTextField.text, !destination.isEmpty,
            let date = dateTextField.text, !date.isEmpty,
            let priceText = priceTextField.text, let price = Int(priceText), price >= 0
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill out all fields correctly.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let currentID = UserDefaults.standard.integer(forKey: "lastListingID")
        let newId = currentID + 1

        UserDefaults.standard.set(newId, forKey: "lastListingID")

        let newListing = RideListing(
            id: newId,
            destination: destination,
            date: date,
            gas_price: "$"+priceText,
            drivers: userProfile.name,
            riders: [userProfile.name]
           )
        delegate?.didPostNewListing(newListing)
        navigationController?.popViewController(animated: true)
    }
    
}



