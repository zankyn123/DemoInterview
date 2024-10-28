//
//  ReachabilityManager.swift
//  ProjectDemo
//
//  Created by Manh Hung on 27/10/24.
//

import Foundation
import Reachability

// swiftlint:disable all
final class ReachabilityManager {
    // MARK: - Priorities
    static var shared: ReachabilityManager = .init()
    private let reachability: Reachability
    var hasInternetConnection: Bool = false
    
    // MARK: - Initialize
    init() {
        reachability = try! .init(hostname: "www.google.com")
        reachability.whenReachable = {[weak self] reachability in
            self?.hasInternetConnection = true
        }
        reachability.whenUnreachable = { [weak self] _ in
            self?.hasInternetConnection = false
            NotificationCenter.default.post(name: .noInternetConnectionNoti, object: nil)
        }
    }
    
    func startNotifier() throws {
        try reachability.startNotifier()
    }
    
    deinit {
        reachability.stopNotifier()
    }
}
