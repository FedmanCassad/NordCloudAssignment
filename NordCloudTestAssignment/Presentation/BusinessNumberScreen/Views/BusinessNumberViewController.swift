//
//  BusinessNumberViewController.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 12.05.2022.
//

import UIKit

final class BusinessNumberViewController: UIViewController {
    
    // MARK: - Private properties
    private let businessCard = BusinessNumberCardView(frame: UIScreen.main.bounds)
    
    // MARK: - Init
    init(withModel model: BusinessNumberViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        businessCard.setViewModel(model: model)
        setupSubviews()
        businessCard.addShadow(offset: CGSize(width: 0, height: -8), color: .black, radius: 16, opacity: 0.1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupSubviews() {
        view.addSubview(businessCard)
        
        NSLayoutConstraint.activate([
            businessCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            businessCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            businessCard.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            businessCard.heightAnchor.constraint(equalToConstant: 121)
        ])
    }
}
