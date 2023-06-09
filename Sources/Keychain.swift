//
//  Keychain.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

/**
 Public Keychain API
 */
public struct Keychain {
    
    /**
     Access the keychain set up with the `kSecClassGenericPassword` class.
     
     See the [`kSecClassGenericPassword`](https://developer.apple.com/documentation/security/ksecclassgenericpassword) for the attributes that apply.
     */
    public static let genericPassword: KeychainGenericPassword = .init(rawClassValue: .genericPassword)
    
    /**
     Access the keychain set up with the `kSecClassInternetPassword` class.
     
     See the [`kSecClassInternetPassword`](https://developer.apple.com/documentation/security/ksecclassinternetpassword) for the attributes that apply.
     */
    public static let internetPassword: KeychainInternetPassword = .init(rawClassValue: .internetPassword)
    
    /**
     Access the keychain set up with the `kSecClassCertificate` class.
     
     See the [`kSecClassCertificate`](https://developer.apple.com/documentation/security/ksecclasscertificate) for the attributes that apply.
     */
    public static let certificate: KeychainCertificate = .init(rawClassValue: .certificate)
    
    /**
     Access the keychain set up with the `kSecClassKey` class.
     
     See the [`kSecClassKey`](https://developer.apple.com/documentation/security/ksecclasskey) for the attributes that apply.
     */
    public static let key: KeychainKey = .init(rawClassValue: .key)
    
    /**
     Access the keychain set up with the `kSecClassIdentity` class.
     
     See the [`kSecClassIdentity`](https://developer.apple.com/documentation/security/ksecclassidentity) for the attributes that apply.
     */
    public static let identity: KeychainIdentity = .init(rawClassValue: .identity)
    
}
