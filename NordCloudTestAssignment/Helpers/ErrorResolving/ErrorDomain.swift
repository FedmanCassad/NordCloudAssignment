//
//  ErrorDomain.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 07.05.2022.
//

import Foundation

enum ErrorDomain: Error {
    case invalidURL
    case noDataReceived
    case parseError
    
    var description: (title: String, message: String) {
        switch self {
        case .invalidURL:
            return ("Network error", "Invalid url provided")
        case .noDataReceived:
            return ("No data error", "No data received")
        case .parseError:
            return ("Network error", "Ops. Can't parse received data, kick developer to fix this problem")
        }
    }
}
