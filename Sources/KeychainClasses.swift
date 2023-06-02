//
//  KeychainClasses.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/04/20.
//

import Foundation

public protocol KeychainCommonItemAttributes {}

public protocol KeychainGenericPasswordItemAttributes: KeychainCommonItemAttributes {}

public protocol KeychainInternetPasswordItemAttributes: KeychainCommonItemAttributes {}

public protocol KeychainCertificateItemAttributes: KeychainCommonItemAttributes {}

public protocol KeychainKeyItemAttributes: KeychainCommonItemAttributes {}

public protocol KeychainIdentityItemAttributes: KeychainCommonItemAttributes,
                                                KeychainCertificateItemAttributes,
                                                KeychainKeyItemAttributes {}

// MARK: - Keychain Item Classes

public struct KeychainGenericPassword: KeychainItemClassType, KeychainGenericPasswordItemAttributes {
    
    public let rawClassValue: KeychainItemClassValue
    
}

public struct KeychainInternetPassword: KeychainItemClassType, KeychainInternetPasswordItemAttributes {
    
    public let rawClassValue: KeychainItemClassValue
    
}

public struct KeychainCertificate: KeychainItemClassType, KeychainCertificateItemAttributes {
    
    public let rawClassValue: KeychainItemClassValue
    
}

public struct KeychainKey: KeychainItemClassType, KeychainKeyItemAttributes {
    
    public let rawClassValue: KeychainItemClassValue
    
}

public struct KeychainIdentity: KeychainItemClassType, KeychainIdentityItemAttributes {
    
    public let rawClassValue: KeychainItemClassValue
    
}
