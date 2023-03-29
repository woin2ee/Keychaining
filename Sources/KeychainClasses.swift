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
    
    public func setAccessControl(_ accessControl: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(accessControl, forKey: .accessControl)
    }
    
    public func setAccessGroup(_ accessGroup: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(accessGroup, forKey: .accessGroup)
    }
    
    public func setAccessible(_ accessible: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(accessible, forKey: .accessible)
    }
    
    public func setCreationDate(_ creationDate: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(creationDate, forKey: .creationDate)
    }
    
    public func setModificationDate(_ modificationDate: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(modificationDate, forKey: .modificationDate)
    }
    
    public func setDescription(_ description: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(description, forKey: .description)
    }
    
    public func setComment(_ comment: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(comment, forKey: .comment)
    }
    
    public func setCreator(_ creator: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(creator, forKey: .creator)
    }
    
    public func setType(_ type: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(type, forKey: .type)
    }
    
    public func setLabel(_ label: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(label, forKey: .label)
    }
    
    public func setIsInvisible(_ isInvisible: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(isInvisible, forKey: .isInvisible)
    }
    
    public func setIsNegative(_ isNegative: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(isNegative, forKey: .isNegative)
    }
    
    public func setAccount(_ account: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(account, forKey: .account)
    }
    
    public func setService(_ service: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(service, forKey: .service)
    }
    
    public func setGeneric(_ generic: KeychainItemAttributeValue) -> SelfReturnType {
        return setAttribute(generic, forKey: .generic)
    }
    
    public func setSynchronizable(_ synchronizable: KeychainItemAttributeValue) -> SelfReturnType {
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
