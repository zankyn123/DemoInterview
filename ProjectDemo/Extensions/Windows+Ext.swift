//
//  Windows+Ext.swift
//  ProjectDemo
//
//  Created by Manh Hung on 26/10/24.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
