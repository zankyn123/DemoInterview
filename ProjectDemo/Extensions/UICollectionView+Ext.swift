//
//  UICollectionView+Ext.swift
//  ProjectDemo
//
//  Created by Manh Hung on 27/10/24.
//

import UIKit

protocol CellReuseIdentifier: CaseIterable, RawRepresentable where RawValue == String {
    var cellClass: AnyClass { get }
}

public protocol HeaderFooterReuseViewIdentifier: CaseIterable, RawRepresentable where RawValue == String {
    var headerFooterClass: AnyClass { get }
}

// swiftlint: disable all
extension UICollectionView {
    func registerReuseCellIdentifier<T: CellReuseIdentifier>(_ cellReuseIdentifier: T.Type) {
        cellReuseIdentifier.allCases.forEach { cellReuseIdentifier in
            let nib = UINib(nibName: cellReuseIdentifier.rawValue, bundle: Bundle.init(for: cellReuseIdentifier.cellClass))
            self.register(nib, forCellWithReuseIdentifier: cellReuseIdentifier.rawValue)
        }
    }
    
    func registerHeaderFooterReuseIdentifier<T: HeaderFooterReuseViewIdentifier>(_ headerFooterReuseViewIdentifier: T.Type, ofKind elementKind: String) {
        headerFooterReuseViewIdentifier.allCases.forEach { headerFooterReuseViewIdentifier in
            let nib = UINib(nibName: headerFooterReuseViewIdentifier.rawValue, bundle: Bundle(for: headerFooterReuseViewIdentifier.headerFooterClass))
            self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: headerFooterReuseViewIdentifier.rawValue)
        }
    }
    
    func dequeueCellReuseIdentifier(_ cellReuseIdentifier: some CellReuseIdentifier, for indexPath: IndexPath) -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier.rawValue, for: indexPath)
    }
    
    public func dequeueHeaderFooterReuseViewIdentifier(_ headerFooterReuseViewIdentifier: some HeaderFooterReuseViewIdentifier,
                                                       ofKind kind: String,
                                                       for indexPath: IndexPath) -> UICollectionReusableView {
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: headerFooterReuseViewIdentifier.rawValue,
                                                for: indexPath)
    }
}
