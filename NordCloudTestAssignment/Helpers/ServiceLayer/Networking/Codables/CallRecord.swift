//
//  CallRecords.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 07.05.2022.
//

import Foundation

struct CallRecords: Codable {
    let requests: [CallRecord]
    
    // MARK: - CallRecord/Request
    struct CallRecord: Codable {
        let id, state: String
        let client: Client
        let type, created: String
        let businessNumber: BusinessNumber
        let origin: String
        let favorite: Bool
        let duration: String
    }
    
    // MARK: - BusinessNumber
    struct BusinessNumber: Codable {
        let number, label: String
    }
    
    // MARK: - Client
    struct Client: Codable {
        let address: String
        let name: String?
        
        enum CodingKeys: String, CodingKey {
            case address
            case name = "Name"
        }
    }
}
