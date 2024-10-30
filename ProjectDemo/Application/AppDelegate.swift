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
        
        addNotificationObserver()
        do {
            try ReachabilityManager.shared.startNotifier()
        } catch { }
        
        startApplicationWindow()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    private func startApplicationWindow() {
        Utils.setRootViewController(viewController: SplashViewController())
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showNoInternetToast), name: .noInternetConnectionNoti, object: nil)
    }
    
    @objc
    func showNoInternetToast() {
        guard let rootVC = Utils.rootVC(), !ReachabilityManager.shared.hasInternetConnection else {
            return
        }
        
        var style = ToastStyle()
        style.messageColor = .red
        rootVC.view.makeToast(L10n.noInternetConnection)
    }
}
