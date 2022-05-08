//
//  ServiceLayer.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 06.05.2022.
//

import Foundation

typealias GenericResult<T: Codable> = Result<T, ErrorDomain>
typealias CallRecordsResult = Result<CallRecords, ErrorDomain>

protocol MissedCallsDataProviderFacade {
    func getCalls() async -> [CallRecords.CallRecord]
}

final class ServiceLayer {
    static let shared = ServiceLayer()
    
    let persistencyService = DomainService()
    let networkService = SimpleNetworkManager()
    
    private init() {}
}

extension ServiceLayer: MissedCallsDataProviderFacade {
    
    var callsNetworkService: NetworkCallRecordsService {
        ServiceLayer.shared.networkService as NetworkCallRecordsService
    }
    
        func getCalls() async -> CallRecordsResult {
            let calls: CallRecordsResult = await networkService.performRequest()
            return calls
        }
}
