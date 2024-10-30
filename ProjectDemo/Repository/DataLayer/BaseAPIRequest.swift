//
//  BaseRequestNetworking.swift
//  ProjectDemo
//
//  Created by Manh Hung on 25/10/24.
//

import Foundation
import DeviceKit

protocol URLRequestConverterProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var apiVersion: String { get }
    var httpMethod: HTTPMethod { get }
    func asUrlRequest() -> URLRequest?
}

protocol APIConfigurationProtocol {
    var queryParams: [String: String] { get }
    var bodyParams: Codable? { get }
    var timeoutRequest: TimeInterval { get }
}

class BaseAPIRequest: URLRequestConverterProtocol, APIConfigurationProtocol {
    var apiVersion: String {
        Constants.apiV4
    }
    
    var baseUrl: String {
        Utils.getBaseUrl()
    }
    
    var httpMethod: HTTPMethod {
        Utils.fatalSubclassMustImpl()
    }
    
    var path: String {
        Utils.fatalSubclassMustImpl()
    }
    
    var queryParams: [String: String] {
        Utils.fatalSubclassMustImpl()
    }
    
    var bodyParams: Codable? {
        return nil
    }
    
    var timeoutRequest: TimeInterval {
        return TimeInterval(60)
    }
    
    func asUrlRequest() -> URLRequest? {
        // Create url
        guard var urlComponents = URLComponents(string: baseUrl + apiVersion + path) else {
            return nil
        }
        // create query items
        urlComponents.queryItems = queryParams.map { (key, value) in
            return URLQueryItem(name: key, value: value)
        }
        // Get url
        guard let url = urlComponents.url else {
            return nil
        }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = timeoutRequest
        request.allHTTPHeaderFields = getHTTPHeadersFields()
        if let bodyParams = bodyParams, let data = try? JSONEncoder().encode(bodyParams),
           [.post, .patch, .put].contains(httpMethod) {
            request.httpBody = data
        }
        return request
    }
    
    private func getHTTPHeadersFields() -> [String: String] {
        let device: Device = Device.current
        var httpHeaderFields: [String: String] = [HTTPHeaderField.contentType.rawValue: HTTPHeaderValue.applicationJson.rawValue,
                                                  HTTPHeaderField.acceptEncoding.rawValue: HTTPHeaderValue.acceptEncoding.rawValue,
                                                  HTTPHeaderField.acceptType.rawValue: HTTPHeaderValue.accept.rawValue,
                                                  HTTPHeaderField.deviceName.rawValue: "\(device.description) - \(device.systemVersion ?? "")",
                                                  HTTPHeaderField.appVersion.rawValue: Bundle.main.shortVersion,
                                                  HTTPHeaderField.productVersion.rawValue: Bundle.main.productVersion]
        if let vendor = UIDevice.current.identifierForVendor {
            httpHeaderFields.updateValue(vendor.uuidString,
                                         forKey: HTTPHeaderField.fingerPrint.rawValue)
        }
        return httpHeaderFields
    }
}
