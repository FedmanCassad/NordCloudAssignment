//
//  CallCellViewModel.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 09.05.2022.
//

import UIKit

protocol CallCellViewModelProtocol {
    /// Name of contact if exist
    var nameOfContact: String? { get }
    /// Phone number
    var phoneNumber: String { get }
    /// Duration
    var duration: String { get }
    /// Date created
    var created: String { get }
    /// Has name flag
    var hasName: Bool { get }
}

final class CallCellViewModel: CallCellViewModelProtocol {
    
    // MARK: - Private properties
    private let callModel: CallRecords.CallRecord
    
    // MARK: - Public properties
    var nameOfContact: String? {
        guard let name = callModel.client.name else { return nil }
        return name
    }
    
    var phoneNumber: String {
        callModel.client.address.getFormattedPhoneNumber(byPattern: .defaultPattern)
    }
    
    var duration: String {
        var duration = callModel.duration
        duration.removeLast(3)
        return duration
    }
    
    var created: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        return formatter.string(from: callModel.created)
    }
    
    var hasName: Bool {
        nameOfContact != nil
    }
    
    init(with callModel: CallRecords.CallRecord) {
        self.callModel = callModel
    }
}
