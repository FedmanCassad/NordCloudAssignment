//
//  UICollectionViewCell+Shadow.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 12.05.2022.
//

import UIKit

extension UICollectionViewCell {
    func shadowDecorate(
        radius: CGFloat = 8,
        shadowColor: UIColor = .black,
        shadowOffset: CGSize = CGSize(width: 0, height: 0),
        shadowRadius: CGFloat = 8,
        shadowOpacity: Float = 0.1
    ) {
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = radius
        
        
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.white.cgColor
        layer.shadowColor = shadowColor.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.shadowRadius = radius
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
    }
}
