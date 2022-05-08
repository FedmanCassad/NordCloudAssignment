//
//  File.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 07.05.2022.
//

import UIKit

final class LockingView: UIView {
    
    // MARK: - Private properties
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialLight))
    private  let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupSubviews() {
        [blurView, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: heightAnchor),
            blurView.widthAnchor.constraint(equalTo: widthAnchor),
            blurView.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
}

extension UIViewController {
    func lockTheView() {
        let lockView = LockingView(frame: UIScreen.main.bounds)
        view.addSubview(lockView)
    }
    
    func unlockTheView() {
        view.subviews.filter{ $0 is LockingView }.forEach{ $0.removeFromSuperview() }
    }
}
