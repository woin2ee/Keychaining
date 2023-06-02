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


// MARK: - KeychainItemClassType

public protocol KeychainItemClassType: KeychainCommonItemAttributes {
    
    var rawClassValue: KeychainItemClassValue { get }
    
}

public protocol KeychainQueryCreatable: KeychainItemClassType {
    
    func makeBasicQuery() -> KeychainBasicQuerySetter<Self>
    
    func makeSaveQuery() -> KeychainSaveQuerySetter<Self>
    
    func makeSearchQuery() -> KeychainSearchQuerySetter<Self>
    
    func makeUpdateQuery() -> KeychainUpdateQuerySetter<Self>
    
    func makeDeleteQuery() -> KeychainDeleteQuerySetter<Self>
    
}

extension KeychainQueryCreatable {
    
    public func makeBasicQuery() -> KeychainBasicQuerySetter<Self> {
        return .init(classValue: rawClassValue)
    }
    
    public func makeSaveQuery() -> KeychainSaveQuerySetter<Self> {
        return .init(classValue: rawClassValue)
    }
    
    public func makeSearchQuery() -> KeychainSearchQuerySetter<Self> {
        return .init(classValue: rawClassValue)
    }
    
    public func makeUpdateQuery() -> KeychainUpdateQuerySetter<Self> {
        return .init(classValue: rawClassValue)
    }
    
    public func makeDeleteQuery() -> KeychainDeleteQuerySetter<Self> {
        return .init(classValue: rawClassValue)
    }
    
}

// MARK: - Keychain Item Classes

public struct KeychainGenericPassword:
    KeychainItemClassType,
    KeychainQueryCreatable,
    KeychainGenericPasswordItemAttributes
{
    
    public let rawClassValue: KeychainItemClassValue
    
}

public struct KeychainInternetPassword:
    KeychainItemClassType,
    KeychainQueryCreatable,
    KeychainInternetPasswordItemAttributes
{
    
    public let rawClassValue: KeychainItemClassValue
    
}

public struct KeychainCertificate:
    KeychainItemClassType,
    KeychainQueryCreatable,
    KeychainCertificateItemAttributes
{
    
    public let rawClassValue: KeychainItemClassValue
    
}

public struct KeychainKey:
    KeychainItemClassType,
    KeychainQueryCreatable,
    KeychainKeyItemAttributes
{
    
    public let rawClassValue: KeychainItemClassValue
    
}

public struct KeychainIdentity:
    KeychainItemClassType,
    KeychainQueryCreatable,
    KeychainIdentityItemAttributes
{
    
    public let rawClassValue: KeychainItemClassValue
    
}
