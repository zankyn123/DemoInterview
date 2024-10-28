//
//  NetworkingFactory.swift
//  ProjectDemo
//
//  Created by Manh Hung on 25/10/24.
//

import Foundation

struct NetworkFactory {
    enum NetworkingType {
        case urlSessions
        // May alamofire
    }
    private let networkService: NetworkingServiceProtocol
    static var `default`: NetworkFactory = NetworkFactory(networkService: URLSessionNetworkingService.shared)
    static var mock: NetworkFactory = NetworkFactory(networkService: NetworkingServerMock())
}

extension NetworkFactory: NetworkingServiceProtocol {
    func requestAPI<T: Codable>(request: URLRequestConverterProtocol & APIConfigurationProtocol) async throws -> T? {
        return try await networkService.requestAPI(request: request)
    }
}
