//
//  CallRecords.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 07.05.2022.
//

import Foundation

struct CallRecords: Codable {
    let calls: [CallRecord]
    
    enum CodingKeys: String, CodingKey {
        case calls = "requests"
    }
    
    // MARK: - CallRecord/Request
    struct CallRecord: Codable {
        let id, state: String
        let client: Client
        let type: String
        let created: Date
        let businessNumber: BusinessNumber
        let origin: String
        let favorite: Bool
        let duration: String
        
        init?(fromManaged model: DomainCall) {
            self.id = model.id
            self.state = model.state
            self.type = model.type
            self.created = model.created
            self.origin = model.origin
            self.favorite = model.favorite
            self.duration = model.duration
            self.client = Client(address: model.client.address, name: model.client.name)
            self.businessNumber = BusinessNumber(number: model.businessNumber.number, label: model.businessNumber.label)
        }
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
