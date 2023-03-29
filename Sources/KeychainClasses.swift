//
//  KeychainClasses.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/29.
//

import Foundation

// MARK: - KeychainSpecificClassType

public protocol KeychainSpecificClassType {
    var rawClassValue: KeychainItemClassValue { get }
}

extension KeychainSpecificClassType {
    
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

// MARK: - KeychainGenericPassword

public struct KeychainGenericPassword: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

extension KeychainItemAttributesSettable where KeychainClass == KeychainGenericPassword {
    
    // TODO: SecAccessControl 생성 API 제공
    public func setAccessControl(_ accessControl: SecAccessControl?) -> SelfReturnType {
        return setAttribute(accessControl, forKey: .accessControl)
    }
    
    public func setAccessGroup(_ accessGroup: String) -> SelfReturnType {
        return setAttribute(accessGroup, forKey: .accessGroup)
    }
    
    public func setAccessible(_ accessible: KeychainItemAttributeAccessibilityValue) -> SelfReturnType {
        return setAttribute(accessible, forKey: .accessible)
    }
    
    public func setCreationDate(_ creationDate: Date) -> SelfReturnType {
        return setAttribute(creationDate, forKey: .creationDate)
    }
    
    public func setModificationDate(_ modificationDate: Date) -> SelfReturnType {
        return setAttribute(modificationDate, forKey: .modificationDate)
    }
    
    public func setDescription(_ description: String) -> SelfReturnType {
        return setAttribute(description, forKey: .description)
    }
    
    public func setComment(_ comment: String) -> SelfReturnType {
        return setAttribute(comment, forKey: .comment)
    }
    
    public func setCreator(_ creator: NSNumber) -> SelfReturnType { // 4바이트 문자 코드 (ex. (abcd) == 0x61626364 == 1633837924)
        return setAttribute(creator, forKey: .creator)
    }
    
    public func setType(_ type: NSNumber) -> SelfReturnType { // 4바이트 문자 코드 (ex. (abcd) == 0x61626364 == 1633837924)
        return setAttribute(type, forKey: .type)
    }
    
    public func setLabel(_ label: String) -> SelfReturnType {
        return setAttribute(label, forKey: .label)
    }
    
    public func setInvisible(_ isInvisible: Bool) -> SelfReturnType {
        return setAttribute(isInvisible, forKey: .isInvisible)
    }
    
    public func setNegative(_ isNegative: Bool) -> SelfReturnType {
        return setAttribute(isNegative, forKey: .isNegative)
    }
    
    public func setAccount(_ account: String) -> SelfReturnType {
        return setAttribute(account, forKey: .account)
    }
    
    public func setService(_ service: String) -> SelfReturnType {
        return setAttribute(service, forKey: .service)
    }
    
    public func setGeneric(_ generic: Data) -> SelfReturnType {
        return setAttribute(generic, forKey: .generic)
    }
    
    public func setSynchronizable(_ synchronizable: KeychainItemAttributeSynchronizabilityValue) -> SelfReturnType {
        return setAttribute(synchronizable, forKey: .synchronizable)
    }
}

// MARK: - KeychainInternetPassword

public struct KeychainInternetPassword: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

extension KeychainItemAttributesSettable where KeychainClass == KeychainInternetPassword {
    
    
}

// MARK: - KeychainCertificate

public struct KeychainCertificate: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

extension KeychainItemAttributesSettable where KeychainClass == KeychainCertificate {
    
    
}

// MARK: - KeychainKey

public struct KeychainKey: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

extension KeychainItemAttributesSettable where KeychainClass == KeychainKey {
    
    
}

// MARK: - KeychainIdentity

public struct KeychainIdentity: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

extension KeychainItemAttributesSettable where KeychainClass == KeychainIdentity {
    
    
}
