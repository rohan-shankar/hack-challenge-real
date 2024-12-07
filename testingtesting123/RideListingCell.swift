import UIKit

class RideListingCell: UITableViewCell {
    static let identifier = "RideListingCell"

    private let driverLabel = UILabel()
    private let priceLabel = UILabel()
    private let dateLabel = UILabel()
    private let destinationLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [driverLabel, priceLabel, dateLabel, destinationLabel])
        stackView.axis = .vertical
//        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        // Set up black and white appearance
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.hack.silver
        contentView.layer.borderColor = UIColor.hack.silver.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true

        driverLabel.textColor = .black
        priceLabel.textColor = .black
        dateLabel.textColor = .black
        destinationLabel.textColor = .black
    }

    func configure(with listing: RideListing) {
        driverLabel.text = "Driver: \(listing.drivers)"
        priceLabel.text = "Price: \(listing.gas_price)"
        dateLabel.text = "Date: \(listing.date)"
        destinationLabel.text = "Destination: \(listing.destination)"
    }
    
    // Add a method to check if user can afford the ride
    func checkAffordability(price: String, userMoney: Int) -> Bool {
        guard let listingPrice = Int(price.trimmingCharacters(in: ["$"])) else { return false }
        return userMoney >= listingPrice
    }

    
}
