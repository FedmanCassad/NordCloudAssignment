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
        tableView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
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
        let result = await ServiceLayer.shared.networkService.performRequest()
            switch result {
            case let .failure(error):
                print(error)
            case let .success(calls):
                print(calls)
            }
            unlockTheView()
        }
    }
    
    private func setupViews() {
        view.addSubview(callsTableView)
        NSLayoutConstraint.activate([
            callsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            callsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            callsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            callsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MissedCallsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        96
    }
}
