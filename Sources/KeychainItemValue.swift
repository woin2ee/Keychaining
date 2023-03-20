//
//  KeychainItemValue.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

protocol KeychainItemValue: RawRepresentable {}

struct KeychainItemClassValue: KeychainItemValue {

    let rawValue: CFString

    static let genericPassword  : KeychainItemClassValue = .init(rawValue: kSecClassGenericPassword)
    static let internetPassword : KeychainItemClassValue = .init(rawValue: kSecClassInternetPassword)
    static let certificate      : KeychainItemClassValue = .init(rawValue: kSecClassCertificate)
    static let key              : KeychainItemClassValue = .init(rawValue: kSecClassKey)
    static let identity         : KeychainItemClassValue = .init(rawValue: kSecClassIdentity)
}

public struct KeychainItemAttributeValue: KeychainItemValue {
    
    public let rawValue: Any
    
    public init(rawValue: Any) {
        self.rawValue = rawValue
    }
    
//    static func string()
}

struct KeychainItemReturnTypeValue: KeychainItemValue {
    
    let rawValue: CFBoolean
    
    static let `true`: KeychainItemReturnTypeValue = .init(rawValue: kCFBooleanTrue)
    static let `false`: KeychainItemReturnTypeValue = .init(rawValue: kCFBooleanFalse)
}

struct KeychainItemValueTypeValue: KeychainItemValue {
    
    let rawValue: Any
    
    static func data(_ data: Data) -> KeychainItemValueTypeValue {
        return .init(rawValue: data)
    }
}
