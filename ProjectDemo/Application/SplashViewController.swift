//
//  SplashViewController.swift
//  ProjectDemo
//
//  Created by Manh Hung on 25/10/24.
//

import UIKit
import Lottie

final class SplashViewController: UIViewController {
    // MARK: - Priorities
    private let animationView = LottieAnimationView(name: "Splash")
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        animationView.frame = view.frame
        view.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let viewController = MainViewController(presenter: .init())
            appDelegate.setRootViewController(viewController: viewController)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animationView.stop()
    }
}
