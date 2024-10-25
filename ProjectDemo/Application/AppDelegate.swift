//
//  AppDelegate.swift
//  ProjectDemo
//
//  Created by Manh Hung on 24/10/24.
//

import UIKit
#if DEBUG
import netfox
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        #if DEBUG
        NFX.sharedInstance().start()
        #endif
        startApplicationWindow()
        return true
    }
    
    func startApplicationWindow() {
        setRootViewController(viewController: SplashViewController())
    }
    
    func setRootViewController(viewController: UIViewController, completion: (() -> Void)? = nil) {
        if let window = window, window.rootViewController != nil {
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
            window?.rootViewController = viewController
            completion?()
        }
        window?.makeKeyAndVisible()
    }
}
