//
//  NetworkingServerMock.swift
//  ProjectDemo
//
//  Created by Manh Hung on 25/10/24.
//

import Foundation

final class MockNetworkingService: NetworkingServiceProtocol {
    func requestAPI<T: Codable>(request: URLRequestConverterProtocol & APIConfigurationProtocol) async throws -> T? {
        return nil
    }
}
