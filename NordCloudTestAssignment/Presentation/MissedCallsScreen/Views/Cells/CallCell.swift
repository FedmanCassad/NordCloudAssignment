//
//  CallCell.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 07.05.2022.
//

import UIKit

final class MissedCallCell: UITableViewCell {
    enum Constants {
        static let iconLeadingConstant: CGFloat = 17
        static let iconTopConstant: CGFloat = 16
        static let iconSideSize: CGFloat = 40
        static let durationHeightConstant: CGFloat = 16
        static let durationTopOffset: CGFloat = 8
        static let contactNameLeadingOffset: CGFloat = 16
        static let contactNameHeightConstant: CGFloat = 24
        static let contactNameWidthConstant: CGFloat = 160
        static let phoneNumberHeightConstant: CGFloat = 22
        static let phoneNumberTopOffset: CGFloat = 2
        static let timestampTrailingOffset: CGFloat = -16
    }
    
    // MARK: - Public type properties(usually cell identifier)
    static let identifier = String(describing: MissedCallCell.self)
    
    // MARK: - Private properties
    private lazy var contactNameTopConstant: CGFloat = viewModel.hasName ? 25 : 12
    private var viewModel: CallCellViewModelProtocol!
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "missedCallIcon")
        return imageView
    }()
    
    private let contactNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        label.textColor = UIColor(hexString: "#333333")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-RegularItalic", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.init(hexString: "#606060")
        return label
    }()
    
    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.init(hexString: "#606060")
        return label
    }()
    
    // MARK: - Public methods
    func configure(with viewModel: CallCellViewModelProtocol) {
        self.viewModel = viewModel
        setupLayout()
        contactNameLabel.text = viewModel.nameOfContact
        phoneNumberLabel.text = viewModel.phoneNumber
        durationLabel.text = viewModel.duration
        timestampLabel.text = viewModel.created
    }
    
    // MARK: - Private methods
    private func setupLayout() {
        [icon, contactNameLabel, phoneNumberLabel, durationLabel, timestampLabel].forEach{
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate(
            [
                icon.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor,
                    constant: Constants.iconLeadingConstant
                ),
                icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.iconTopConstant),
                icon.widthAnchor.constraint(equalToConstant: Constants.iconSideSize),
                icon.heightAnchor.constraint(equalToConstant: Constants.iconSideSize),
                
                durationLabel.heightAnchor.constraint(equalToConstant: Constants.durationHeightConstant),
                durationLabel.centerXAnchor.constraint(equalTo: icon.centerXAnchor),
                durationLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: Constants.durationTopOffset),
                
                contactNameLabel.leadingAnchor.constraint(
                    equalTo: icon.trailingAnchor,
                    constant: Constants.contactNameLeadingOffset
                ),
                contactNameLabel.heightAnchor.constraint(equalToConstant: Constants.contactNameHeightConstant),
                contactNameLabel.widthAnchor.constraint(equalToConstant: Constants.contactNameWidthConstant),
                contactNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contactNameTopConstant),
                
                phoneNumberLabel.heightAnchor.constraint(equalToConstant: Constants.phoneNumberHeightConstant),
                phoneNumberLabel.leadingAnchor.constraint(equalTo: contactNameLabel.leadingAnchor),
                phoneNumberLabel.topAnchor.constraint(
                    equalTo: contactNameLabel.bottomAnchor,
                    constant: Constants.phoneNumberTopOffset
                ),
                
                timestampLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                timestampLabel.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: Constants.timestampTrailingOffset
                )
            ]
        )
    }
}
