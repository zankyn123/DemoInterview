//
//  CharacterSet+Ext.swift
//  ProjectDemo
//
//  Created by Manh Hung on 30/10/24.
//

import Foundation

extension CharacterSet {
    static var ipv4AddressCharset: CharacterSet {
        CharacterSet(charactersIn: "0123456789.")
    }

    static var ipv6AddressCharset: CharacterSet {
        CharacterSet(charactersIn: "0123456789abcdef:.")
    }
}
