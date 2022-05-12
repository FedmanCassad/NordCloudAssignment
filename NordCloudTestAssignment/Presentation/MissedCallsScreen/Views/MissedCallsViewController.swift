//
//  ViewController.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 05.05.2022.
//

import UIKit

class MissedCallsViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var callsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = viewModel
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(MissedCallCell.self, forCellReuseIdentifier: MissedCallCell.identifier)
        return tableView
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
            callsTableView.reloadData()
        }
    }
    
    private func setupViews() {
        view.addSubview(callsTableView)
        NSLayoutConstraint.activate([
            callsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            callsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            callsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            callsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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

extension MissedCallsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let businessModel = viewModel.makeBusinessCardViewModel(at: indexPath) else { return }
        let businessCardVC = BusinessNumberViewController(withModel: businessModel)
        let customDetent: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test1", constant: 137.0)
        if let sheet = businessCardVC.sheetPresentationController {
            sheet.detents = [customDetent]
        }
        tableView.deselectRow(at: indexPath, animated: true)
        present(businessCardVC, animated: true)
    }
}
