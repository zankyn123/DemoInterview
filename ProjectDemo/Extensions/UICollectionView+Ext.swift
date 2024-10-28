//
//  UICollectionView+Ext.swift
//  ProjectDemo
//
//  Created by Manh Hung on 27/10/24.
//

import UIKit

// swiftlint: disable all
extension UICollectionView {
    func dequeueCellFor<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let cellIdentifier = String(describing: cellClass)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable collection view cell: \(T.self)")
        }
        return cell
    }
    
    func registerCell(_ cellClass: UICollectionViewCell.Type, bundle: Bundle = .main) {
        let cellIdentifier = String(describing: cellClass)
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func registerReusableView<T: UICollectionReusableView>(for type: T.Type, ofKind elementKind: String) {
        self.register(UINib(nibName: String(describing: type), bundle: Bundle(for: type)),
                      forSupplementaryViewOfKind: elementKind,
                      withReuseIdentifier: String(describing: type))
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String,
                                                                              for indexPath: IndexPath) -> T {
        guard let section = dequeueReusableSupplementaryView(ofKind: kind,
                                                             withReuseIdentifier: String(describing: T.self),
                                                             for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable supplementary view: \(T.self)")
        }
        return section
    }
}
