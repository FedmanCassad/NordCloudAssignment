//
//  File.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 12.05.2022.
//

import UIKit

final class BusinessNumberCardView: UIView {
    
    //MARK: - Private properties
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.textColor = UIColor(hexString: "#A0A0A0")
        label.numberOfLines = 1
        label.text = "Business number"
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProDisplay-Bold", size: 17)
        label.textColor = UIColor(hexString: "#333333")
        label.numberOfLines = 1
        return label
    }()
    
    private let numberValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.numberOfLines = 1
        label.textColor = UIColor(hexString: "#606060")
        return label
    }()
    
    private var viewModel: BusinessNumberViewModelProtocol! {
        didSet {
            numberLabel.text = viewModel.numberLabelString
            numberValueLabel.text = viewModel.numberString
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
        makeRounded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setViewModel(model: BusinessNumberViewModelProtocol) {
        self.viewModel = model
    }
    
    // MARK: - Private methods
    
    private func makeRounded() {
        layer.masksToBounds = false
        layer.cornerCurve = .continuous
        layer.cornerRadius = 16
    }
    
    private func setupSubviews() {
        [categoryLabel, numberLabel, numberValueLabel].forEach { view in
            addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            categoryLabel.heightAnchor.constraint(equalToConstant: 21),
            
            numberLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            numberLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor),
            numberLabel.heightAnchor.constraint(equalToConstant: 22),
            
            numberValueLabel.leadingAnchor.constraint(equalTo: numberLabel.leadingAnchor),
            numberValueLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 8),
            numberValueLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
