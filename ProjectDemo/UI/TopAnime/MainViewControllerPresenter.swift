//
//  MainViewControllerPresenter.swift
//  ProjectDemo
//
//  Created by Manh Hung on 26/10/24.
//

import Foundation

@MainActor
protocol MainViewControllerPresenterDelegate: AnyObject {
    func onLoadedEntities(_ entities: [MainViewControllerEntity], hasMore: Bool)
}

final class MainViewControllerPresenter {
    // MARK: - Variables
    weak var delegate: MainViewControllerPresenterDelegate?
    private let apiRequest: TopAnimeAPIRequest = .init(.default)
    private var currentPage: Int = 1
    
    func getListAnimes() {
        Task {
            do {
                let datas: TopAnimeResModel? = try await apiRequest.getTopAnime(page: currentPage)
                currentPage += 1
                let entities = datas?.mappingToEntities() ?? []
                await delegate?.onLoadedEntities(entities, hasMore: currentPage <= 3)
            } catch {
                if let apiError = error as? APIError {
                    switch apiError {
                    case .errorResponse(let modelError):
                        debugPrint(modelError?.statusCode ?? "error status code \(-999)")
                    default:
                        debugPrint(error)
                    }
                } else {
                    debugPrint(error)
                }
            }
        }
    }
}
