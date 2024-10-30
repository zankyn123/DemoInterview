//
//  Bundle+Ext.swift
//  ProjectDemo
//
//  Created by Manh Hung on 30/10/24.
//

import Foundation

extension Bundle {
    /// Returns the product version string based on the following rules:
    ///
    /// 1. Dev builds (debug): project-demo-debug-XXXX.YY-devZ
    /// 2. TestFlight builds: project-demo-XXXX.YY-betaZ
    /// 3. AppStore builds: XXXX.YY
    ///
    /// Note: XXXX.YY is an app version (i.e 2020.5) and Z is a build number (i.e 1)
    var productVersion: String {
        let shortVersions = object(forInfoDictionaryKey: Constants.bundleShortVersionKey) as? String ?? ""
        let buildNumber = object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ??
            "???"
        #if DEBUG
        return "project-demo-debug-\(shortVersions)-dev\(buildNumber)"
        #else
        if appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" {
            return "project-demo-\(shortVersions)-beta\(buildNumber)"
        } else {
            return "project-demo-\(shortVersions)"
        }
        #endif
    }
    
    var shortVersion: String {
        object(forInfoDictionaryKey: Constants.bundleShortVersionKey) as? String ?? ""
    }
}
