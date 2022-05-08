//
//  SimpleNetworkManager.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 06.05.2022.
//

import Foundation

final class SimpleNetworkManager {
    
    // MARK: - Public properties
    lazy var domainService = ServiceLayer.shared.persistencyService
    
    // MARK: - Private properties
    private var url: URL? = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "5e3c202ef2cb300014391b5a.mockapi.io"
        components.path = "/testapi"
        return components.url
    }()
    
    func performRequest<T>() async -> GenericResult<T> {
        guard let request = constructCallsRequest() else {
            return .failure(.invalidURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let calls = try? JSONDecoder().decode(T.self, from: data) else {
                return .failure(.parseError)
            }
            return .success(calls)
        } catch {
            return .failure(.noDataReceived)
        }
    }
    
    private func constructCallsRequest() -> URLRequest? {
        guard let url = url else {
            return nil
        }
        return URLRequest(url: url)
    }
}
