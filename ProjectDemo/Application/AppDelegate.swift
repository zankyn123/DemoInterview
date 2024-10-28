//
//  AppDelegate.swift
//  ProjectDemo
//
//  Created by Manh Hung on 24/10/24.
//

import UIKit
import Toast_Swift
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
        
        notificationObserver()
        do {
            try ReachabilityManager.shared.startNotifier()
        } catch { }
        
        startApplicationWindow()
        return true
    }
    
    func startApplicationWindow() {
        setRootViewController(viewController: SplashViewController())
    }
    
    func notificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showNoInternetToast), name: .noInternetConnectionNoti, object: nil)
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
    
    @objc
    func showNoInternetToast() {
        guard let rootVC = Utils.rootVC(), !ReachabilityManager.shared.hasInternetConnection else {
            return
        }
        
        var style = ToastStyle()
        style.messageColor = .red
        rootVC.view.makeToast(ProjectLanguage.noInternetConnection)
    }
}
