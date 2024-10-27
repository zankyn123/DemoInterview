//
//  NetworkingDefinition.swift
//  ProjectDemo
//
//  Created by Manh Hung on 25/10/24.
//

import Foundation

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case appVersion = "APP-VERSION"
    case deviceName = "DEVICE-NAME"
    case fingerPrint = "X-Request-Fingerprint"
}

public enum HTTPHeaderValue: String {
    case applicationJson = "application/json"
    case accept = "application/json, text/plain, */*"
    case acceptEncoding = "gzip, deflate, br"
}

public enum RequestError: Error {
    case userCancelRequest
    case unimplement
    case unknown
}

public enum APIError: Error {
    case timeout
    case noInternet
    case internalError
    case errorResponse(ModelError?)
}

public struct ModelError {
    var statusCode: Int
    var responseData: Data
}
