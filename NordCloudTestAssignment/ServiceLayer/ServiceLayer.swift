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
    /// Under-hood should ask networkService first then in case of error ask persistent store to fetch
    /// previously saved calls.
    /// - Returns: Returns <[CallRecord], DomainError>.
    func getCalls() async -> CallRecordsResult
}

final class ServiceLayer {
    
    // MARK: - Singleton
    static let shared = ServiceLayer()
    
    /// Private services
    private let persistencyService = DomainService()
    private let networkService = SimpleNetworkManager()
    
    private init() {}
}

extension ServiceLayer: MissedCallsDataProviderFacade {
    
    func getCalls() async -> CallRecordsResult {
        let callsResult: CallRecordsResult = await networkService.performRequest()
        switch callsResult {
        case .success(let calls):
            saveCalls(calls: calls.calls)
            return .success(calls)
        case .failure(_):
            guard let calls = persistencyService.fetchData(for: DomainCall.self) else {
                return .failure(.noDataReceived)
            }
            return .success(CallRecords(calls: calls.compactMap{ CallRecords.CallRecord(fromManaged: $0) }))
        }
    }
    
    private func saveCalls(calls: [CallRecords.CallRecord]) {
        calls.forEach { plainCall in
            let call: DomainCall = persistencyService.createObject()
            call.id = plainCall.id
            call.created = plainCall.created
            call.duration = plainCall.duration
            call.favorite = plainCall.favorite
            call.origin = plainCall.origin
            call.state = plainCall.state
            call.type = plainCall.type
            call.client = persistencyService.createObject()
            call.client.address = plainCall.client.address
            call.client.name = plainCall.client.name
            call.businessNumber = persistencyService.createObject()
            call.businessNumber.number = plainCall.businessNumber.number
            call.businessNumber.label = plainCall.businessNumber.label
        }
        persistencyService.save()
    }
}
