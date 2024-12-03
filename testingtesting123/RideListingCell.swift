import UIKit

class RideListingCell: UITableViewCell {
    static let identifier = "RideListingCell"

    private let driverLabel = UILabel()
    private let priceLabel = UILabel()
    private let locationLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [driverLabel, priceLabel, locationLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        // Set up black and white appearance
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true

        driverLabel.textColor = .black
        priceLabel.textColor = .black
        locationLabel.textColor = .black
    }

    func configure(with listing: RideListing) {
        driverLabel.text = "Driver: \(listing.driver)"
        priceLabel.text = "Price: \(listing.price)"
        locationLabel.text = "Location: \(listing.location)"
    }
}
