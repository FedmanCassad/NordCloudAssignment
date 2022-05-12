//
//  MissedCallsScreenViewModel.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 05.05.2022.
//

import Foundation
import UIKit

typealias MissedCallsScreenViewModelDatasource = MissedCallsScreenViewModelProtocol & UICollectionViewDataSource

protocol MissedCallsScreenViewModelProtocol: AnyObject {
    /// Asks service layer to load call records from two possible sources(second service asks in case of network service malfunction)
    func retrieveMissedCallsData() async
    /// Kind of factory method, produce model for bottomSheet view.
    /// - Parameter indexPath: tableView's row IndexPath
    /// - Returns: returns BusinessNumberViewModel covered by protocol
    func makeBusinessCardViewModel(at indexPath: IndexPath) -> BusinessNumberViewModelProtocol?
    /// Needs to show alert message in case of error occurring
    var onErrorHandler: ((ErrorDomain) -> Void)? { get set }
}

final class MissedCallsScreenViewModel: NSObject {
    
    // MARK: - Private properties
    private let serviceLayer: MissedCallsDataProviderFacade = ServiceLayer.shared
    private var calls: [CallRecords.CallRecord]?
    
    // MARK: - Public properties
    var onErrorHandler: ((ErrorDomain) -> Void)?
    
    // MARK: - Public methods
    func retrieveMissedCallsData() async {
        let result = await serviceLayer.getCalls()
        switch result {
        case let .failure(error):
            onErrorHandler?(error)
        case let .success(callsResponse):
            calls = callsResponse.calls
        }
    }
    
    // MARK: - Public methods
    func makeBusinessCardViewModel(at indexPath: IndexPath) -> BusinessNumberViewModelProtocol? {
        guard let calls = calls,
              indexPath.row < calls.count
        else { return nil }
        let callModel = calls[indexPath.row]
        let businessModel =  BusinessNumberViewModel(
            labelString: callModel.businessNumber.label,
            numberString: callModel.businessNumber.number
        )
        return businessModel
    }
    
    // MARK: - Private methods
    private func makeCellViewModel(forCellAt indexPath: IndexPath) -> CallCellViewModelProtocol? {
        guard let callRecord = calls?[indexPath.row] else { return nil }
        return CallCellViewModel(with: callRecord)
    }
}

// MARK: - UITableViewDataSource
extension MissedCallsScreenViewModel: MissedCallsScreenViewModelDatasource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MissedCallCell.identifier,
            for: indexPath
        ) as? MissedCallCell,
              let cellModel = makeCellViewModel(forCellAt: indexPath)
        else { return UICollectionViewCell() }
        cell.configure(with: cellModel)
        return cell
    }
}
