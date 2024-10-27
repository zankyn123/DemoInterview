//
//  TopAnimeAPIRequest.swift
//  ProjectDemo
//
//  Created by Manh Hung on 26/10/24.
//

import Foundation

final class TopAnimeAPIRequest: BaseRequest {
    enum Function {
        case listTopAnime(_ currentPage: Int)
    }
    var function: Function?
    var networking: NetworkFactory
    
    override var httpMethod: HTTPMethod {
        switch function {
        case .listTopAnime:
            return .get
        case .none:
            return .get
        }
    }
    
    override var path: String {
        switch function {
        case .listTopAnime:
            return "/top/anime"
        case .none:
            return ""
        }
    }
    
    override var queryParams: [String: String] {
        switch function {
        case .listTopAnime(let page):
            return ["page": "\(page)"]
        case .none:
            return [:]
        }
    }
    
    init(_ networkFactory: NetworkFactory = .default) {
        self.networking = networkFactory
    }
    
    func getTopAnime(page: Int) async throws -> TopAnimeResModel? {
        function = .listTopAnime(page)
        return try await networking.requestAPI(request: self)
    }
}
