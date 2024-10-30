//
//  Utils.swift
//  ProjectDemo
//
//  Created by Manh Hung on 26/10/24.
//

import UIKit
import Reachability
import Toast_Swift
import os

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
                                             message: message ?? L10n.somethingError,
                                             preferredStyle: .alert)
        let alertAction = UIAlertAction(title: L10n.ok, style: .cancel)
        alertErrorVC.addAction(alertAction)
        rootVC.present(alertErrorVC, animated: true)
    }
    
    static func rootVC() -> UIViewController? {
        let windows = UIWindow.key
        return windows?.rootViewController
    }
    
    static func setRootViewController(viewController: UIViewController, completion: (() -> Void)? = nil) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        if let window = appDelegate.window, window.rootViewController != nil {
            let navigation = UINavigationController(rootViewController: viewController)
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            window.rootViewController = navigation
            let duration: TimeInterval = 0.3
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: { _ in
                window.makeKeyAndVisible()
                completion?()
            })
        } else {
            // Splash screen
            appDelegate.window?.rootViewController = viewController
            completion?()
        }
        appDelegate.window?.makeKeyAndVisible()
    }
    
    static func fatalSubclassMustImpl() -> Never {
        fatalError("Subclass must implement")
    }
}
