//
//  TopAnimeResModel.swift
//  ProjectDemo
//
//  Created by Manh Hung on 26/10/24.
//

import Foundation

// MARK: - Welcome
struct TopAnimeResModel: Codable {
    let pagination: Pagination?
    let datas: [Datum]?
    
    enum CodingKeys: String, CodingKey {
        case pagination
        case datas = "data"
    }
    
    func mappingToEntities() -> [MainViewControllerEntity] {
        guard let datas = datas else {
            return []
        }
        let entities: [MainViewControllerEntity] = datas.map { item in
            let title: String = item.title ?? ""
            let largeImageStr: String = item.images?[Constants.jpgKey]?.largeImageURL ?? ""
            return .init(title: title, largeImageUrl: URL(string: largeImageStr))
        }
        return entities
    }
}

// MARK: - Datum
struct Datum: Codable {
    let malID: Int?
    let url: String?
    let images: [String: Image]?
    let trailer: Trailer?
    let approved: Bool?
    let title: String?
}

// MARK: - Image
struct Image: Codable {
    let imageURL, smallImageURL, largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Trailer
struct Trailer: Codable {
    let youtubeID: String?
    let url, embedURL: String?
    let images: Images?

    enum CodingKeys: String, CodingKey {
        case youtubeID = "youtube_id"
        case url
        case embedURL = "embed_url"
        case images
    }
}

// MARK: - Images
struct Images: Codable {
    let imageURL, smallImageURL, mediumImageURL, largeImageURL: String?
    let maximumImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case mediumImageURL = "medium_image_url"
        case largeImageURL = "large_image_url"
        case maximumImageURL = "maximum_image_url"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let lastVisiblePage: Int?
    let hasNextPage: Bool?
    let currentPage: Int?
    let items: Items?

    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
        case currentPage = "current_page"
        case items
    }
}

// MARK: - Items
struct Items: Codable {
    let count, total, perPage: Int?

    enum CodingKeys: String, CodingKey {
        case count, total
        case perPage = "per_page"
    }
}
