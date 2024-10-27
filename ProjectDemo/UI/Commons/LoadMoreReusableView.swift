//
//  LoadMoreReusableView.swift
//  ProjectDemo
//
//  Created by Manh Hung on 28/10/24.
//

import UIKit

final class LoadMoreReusableView: UICollectionReusableView {
    // MARK: - IBOutlets
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public funcs
    func startAnimation() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimation() {
        activityIndicator.stopAnimating()
    }
}
