//
//  Utils.swift
//  ProjectDemo
//
//  Created by Manh Hung on 26/10/24.
//

import UIKit
import Reachability
import Toast_Swift

struct Utils {
    static func getBaseUrl() -> String {
        #if DEBUG
        return "https://api.jikan.moe/"
        #else
        return "https://api.jikan.moe/"
        #endif
    }
    
    @MainActor
    static func showAlertError(title: String? = nil, message: String? = nil) {
        guard let rootVC = Utils.rootVC(),
              !(rootVC is UIAlertController) else {
            return
        }
        
        let alertErrorVC = UIAlertController(title: title ?? "",
                                             message: message ?? ProjectLanguage.somethingError,
                                             preferredStyle: .alert)
        let alertAction = UIAlertAction(title: ProjectLanguage.ok, style: .cancel)
        alertErrorVC.addAction(alertAction)
        rootVC.present(alertErrorVC, animated: true)
    }
    
    static func rootVC() -> UIViewController? {
        let windows = UIWindow.key
        return windows?.rootViewController
    }
    
    static func fatalSubclassMustImpl() -> Never {
        fatalError("Subclass must implement")
    }
}
