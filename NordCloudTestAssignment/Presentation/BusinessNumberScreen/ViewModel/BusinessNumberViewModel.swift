//
//  BusinessNumberViewModel.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 12.05.2022.
//

import Foundation

protocol BusinessNumberViewModelProtocol {
    /// Formatted string for number label
    var numberLabelString: String { get }
    /// Formatted string for phone number
    var numberString: String { get }
}

final class BusinessNumberViewModel: BusinessNumberViewModelProtocol {
    private(set) var numberLabelString: String
    private(set) var numberString: String
    
    init(labelString: String, numberString: String) {
        self.numberLabelString = labelString
        self.numberString = numberString.getFormattedPhoneNumber(byPattern: .defaultPattern)
    }
}
