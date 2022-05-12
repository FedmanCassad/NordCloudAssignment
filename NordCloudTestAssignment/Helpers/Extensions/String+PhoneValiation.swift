//
//  String+PhoneValiation.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 12.05.2022.
//

import Foundation

extension String {
    enum PhoneFormattingPatterns: String {
        case defaultPattern = #"^([+]{1}\d{1})(\d{3})(\d{3})(\d{4})$"#
    }
    
    func getFormattedPhoneNumber(byPattern: PhoneFormattingPatterns) -> String {
        return self.replacingOccurrences(
            of: PhoneFormattingPatterns.defaultPattern.rawValue,
            with: "$1 $2 $3-$4",
            options: .regularExpression
        )
    }
}
