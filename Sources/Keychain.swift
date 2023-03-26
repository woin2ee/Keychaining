//
//  Keychain.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

public struct Keychain {
    
    private let `class`: KeychainItemClassValue
    
    private init(class: KeychainItemClassValue) {
        self.class = `class`
    }
    
    /**
     Access the keychain set up with the `kSecClassGenericPassword` class.
     
     See the [`kSecClassGenericPassword`](https://developer.apple.com/documentation/security/ksecclassgenericpassword) for the attributes that apply.
     */
    public static let genericPassword: Keychain = .init(class: .genericPassword)
    
    /**
     Access the keychain set up with the `kSecClassInternetPassword` class.
     
     See the [`kSecClassInternetPassword`](https://developer.apple.com/documentation/security/ksecclassinternetpassword) for the attributes that apply.
     */
    public static let internetPassword: Keychain = .init(class: .internetPassword)
    
    /**
     Access the keychain set up with the `kSecClassCertificate` class.
     
     See the [`kSecClassCertificate`](https://developer.apple.com/documentation/security/ksecclasscertificate) for the attributes that apply.
     */
    public static let certificate: Keychain = .init(class: .certificate)
    
    /**
     Access the keychain set up with the `kSecClassKey` class.
     
     See the [`kSecClassKey`](https://developer.apple.com/documentation/security/ksecclasskey) for the attributes that apply.
     */
    public static let key: Keychain = .init(class: .key)
    
    /**
     Access the keychain set up with the `kSecClassIdentity` class.
     
     See the [`kSecClassIdentity`](https://developer.apple.com/documentation/security/ksecclassidentity) for the attributes that apply.
     */
    public static let identity: Keychain = .init(class: .identity)
    
    /**
     
     */
    public func makeQuery() -> KeychainQuery {
        return .init(classValue: self.class)
    }
    
    /**
     
     */
    public func makeSaveQuery() -> KeychainSaveQuery {
        return .init(classValue: self.class)
    }
    
    /**
     
     */
    public func makeSearchQuery() -> KeychainSearchQuery {
        return .init(classValue: self.class)
    }
    
    /**
     
     */
    public func makeUpdateQuery() -> KeychainUpdateQuery {
        return .init(classValue: self.class)
    }
    
    /**
     
     */
    public func makeDeleteQuery() -> KeychainDeleteQuery {
        return .init(classValue: self.class)
    }
}
