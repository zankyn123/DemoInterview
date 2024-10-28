//
//  NetworkingFactory.swift
//  ProjectDemo
//
//  Created by Manh Hung on 25/10/24.
//

import Foundation

struct NetworkServiceFactory {
    enum NetworkingType {
        case urlSessions
        // May alamofire
    }
    private let networkService: NetworkingServiceProtocol
    static var `default`: NetworkServiceFactory = NetworkServiceFactory(networkService: URLSessionNetworkingService.shared)
    static var mock: NetworkServiceFactory = NetworkServiceFactory(networkService: MockNetworkingService())
}

extension NetworkServiceFactory: NetworkingServiceProtocol {
    func requestAPI<T: Codable>(request: URLRequestConverterProtocol & APIConfigurationProtocol) async throws -> T? {
        return try await networkService.requestAPI(request: request)
    }
}
