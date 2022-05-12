//
//  ViewController.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 05.05.2022.
//

import UIKit

class MissedCallsViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var callsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = viewModel
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = false
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MissedCallCell.self, forCellWithReuseIdentifier: MissedCallCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    let viewModel: MissedCallsScreenViewModelDatasource
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    // MARK: - Init
    init(with model: MissedCallsScreenViewModelDatasource) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
        viewModel.onErrorHandler = showErrorAlert(error:)
        setupViews()
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        Task {
            lockTheView()
            await viewModel.retrieveMissedCallsData()
            unlockTheView()
            callsCollection.reloadData()
        }
    }
    
    private func setupViews() {
        view.addSubview(callsCollection)
        NSLayoutConstraint.activate([
            callsCollection.topAnchor.constraint(equalTo: view.topAnchor),
            callsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            callsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            callsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func showErrorAlert(error: ErrorDomain) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(
                title: error.description.title,
                message: error.description.message,
                preferredStyle: .alert
            )
            let dismissAction = UIAlertAction(title: "Ok then", style: .default)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true)
        }
    }
}

extension MissedCallsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let businessModel = viewModel.makeBusinessCardViewModel(at: indexPath) else { return }
        let businessCardVC = BusinessNumberViewController(withModel: businessModel)
        let customDetent: UISheetPresentationController.Detent = ._detent(withIdentifier: "Custom", constant: 121.0)
        if let sheet = businessCardVC.sheetPresentationController {
            sheet.detents = [customDetent]
        }
        collectionView.deselectItem(at: indexPath, animated: true)
        present(businessCardVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // --Dunno how but this tricky dog-nail works as expected without any warnings.
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
