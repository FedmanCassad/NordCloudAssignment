//
//  SimpleNetworkManager.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 06.05.2022.
//

import Foundation

final class SimpleNetworkManager {
    
    // MARK: - Private properties
    private var url: URL? = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "5e3c202ef2cb300014391b5a.mockapi.io"
        components.path = "/testapi"
        return components.url
    }()
    
    // MARK: - Public methods
    func performRequest<T>() async -> GenericResult<T> {
        guard let request = constructCallsRequest() else {
            return .failure(.invalidURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            guard let calls = try? decoder.decode(T.self, from: data) else {
                return .failure(.parseError)
            }
            return .success(calls)
        } catch {
            return .failure(.noDataReceived)
        }
    }
    
    // MARK: - Private methods
    private func constructCallsRequest() -> URLRequest? {
        guard let url = url else {
            return nil
        }
        return URLRequest(url: url)
    }
}
