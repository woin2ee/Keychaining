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
}

// MARK: - Make query with initalized class type

public extension Keychain {
    
    /**
     
     */
    func makeBasicQuery() -> KeychainBasicQuerySetter {
        return .init(classValue: self.class)
    }
    
    /**
     
     */
    func makeSaveQuery() -> KeychainSaveQuerySetter {
        return .init(classValue: self.class)
    }
    
    /**
     
     */
    func makeSearchQuery() -> KeychainSearchQuerySetter {
        return .init(classValue: self.class)
    }
    
    /**
     
     */
    func makeUpdateQuery() -> KeychainUpdateQuerySetter {
        return .init(classValue: self.class)
    }
    
    /**
     
     */
    func makeDeleteQuery() -> KeychainDeleteQuerySetter {
        return .init(classValue: self.class)
    }
}

// MARK: - Make query without initialized class type

public extension Keychain {
    
    /**
     
     */
    static func makeBasicQuery() -> KeychainBasicQuerySetter {
        return .init([:])
    }
    
    /**
     
     */
    static func makeSaveQuery() -> KeychainSaveQuerySetter {
        return .init([:])
    }
    
    /**
     
     */
    static func makeSearchQuery() -> KeychainSearchQuerySetter {
        return .init([:])
    }
    
    /**
     
     */
    static func makeUpdateQuery() -> KeychainUpdateQuerySetter {
        return .init([:])
    }
    
    /**
     
     */
    static func makeDeleteQuery() -> KeychainDeleteQuerySetter {
        return .init([:])
    }
    
    /**
     
     */
    static func makeDictionary() -> KeychainDictionary {
        return .init()
    }
}
