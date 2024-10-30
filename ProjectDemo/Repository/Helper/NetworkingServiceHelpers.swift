//
//  NetworkingServiceHelpers.swift
//  ProjectDemo
//
//  Created by Manh Hung on 30/10/24.
//

import Foundation
import os

final class NetworkingServiceHelpers {
    private let logging = Logger(subsystem: "com.manhhung.ProjectDemo.Repository", category: "networking")
    
    func printRequest(request: URLRequest) {
        #if DEBUG
        guard let method = request.httpMethod,
              let urlString = request.url?.absoluteString else { return }
        logging.trace("==> \(method) \(urlString)")
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            let headerMsg: String = headers
                .map {
                    "\($0.key): \($0.value)"
                }
                .joined(separator: "\n")
            logging.info("HEADERS: \n\(headerMsg)")
        }
        
        if let data = request.httpBody,
           let bodyString = String(data: data, encoding: .utf8) {
            logging.info("BODY: \(bodyString)")
        }
        #endif
    }
    
    func printResponse(data: Data, request: URLRequest, response: HTTPURLResponse) {
        #if DEBUG
        guard let method = request.httpMethod,
              let urlString = request.url?.absoluteString else { return }
        logging.info("<== \(response.statusCode) \(method) \(urlString)")
        let headerMsg: String = response.allHeaderFields
            .map {
                "\($0.key): \($0.value)"
            }
            .joined(separator: "\n")
        logging.info("HEADERS: \n\(headerMsg)")
        
        if let responseString = String(data: data, encoding: .utf8) {
            logging.info("RESPONSE: \(responseString)")
        }
        #endif
    }
}
