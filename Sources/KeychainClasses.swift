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

public struct KeychainGenericPassword: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

public struct KeychainInternetPassword: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

public struct KeychainCertificate: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

public struct KeychainKey: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

public struct KeychainIdentity: KeychainSpecificClassType {
    public let rawClassValue: KeychainItemClassValue
}

// MARK: - All attribute setting methods.

private extension KeychainItemAttributesSettable {
    
    // TODO: SecAccessControl 생성 API 제공
    func _setAccessControl(_ accessControl: SecAccessControl?) -> SelfReturnType {
        return setAttribute(accessControl, forKey: .accessControl)
    }
    
    func _setAccessGroup(_ accessGroup: String) -> SelfReturnType {
        return setAttribute(accessGroup, forKey: .accessGroup)
    }
    
    func _setAccessible(_ accessible: KeychainItemAttributeAccessibilityValue) -> SelfReturnType {
        return setAttribute(accessible, forKey: .accessible)
    }
    
    func _setCreationDate(_ creationDate: Date) -> SelfReturnType {
        return setAttribute(creationDate, forKey: .creationDate)
    }
    
    func _setModificationDate(_ modificationDate: Date) -> SelfReturnType {
        return setAttribute(modificationDate, forKey: .modificationDate)
    }
    
    func _setDescription(_ description: String) -> SelfReturnType {
        return setAttribute(description, forKey: .description)
    }
    
    func _setComment(_ comment: String) -> SelfReturnType {
        return setAttribute(comment, forKey: .comment)
    }
    
    func _setCreator(_ creator: NSNumber) -> SelfReturnType { // 4바이트 문자 코드 (ex. (abcd) == 0x61626364 == 1633837924)
        return setAttribute(creator, forKey: .creator)
    }
    
    func _setType(_ type: NSNumber) -> SelfReturnType { // 4바이트 문자 코드 (ex. (abcd) == 0x61626364 == 1633837924)
        return setAttribute(type, forKey: .type)
    }
    
    func _setLabel(_ label: String) -> SelfReturnType {
        return setAttribute(label, forKey: .label)
    }
    
    func _setInvisible(_ isInvisible: Bool) -> SelfReturnType {
        return setAttribute(isInvisible, forKey: .isInvisible)
    }
    
    func _setNegative(_ isNegative: Bool) -> SelfReturnType {
        return setAttribute(isNegative, forKey: .isNegative)
    }
    
    func _setAccount(_ account: String) -> SelfReturnType {
        return setAttribute(account, forKey: .account)
    }
    
    func _setService(_ service: String) -> SelfReturnType {
        return setAttribute(service, forKey: .service)
    }
    
    func _setGeneric(_ generic: Data) -> SelfReturnType {
        return setAttribute(generic, forKey: .generic)
    }
    
    func _setSynchronizable(_ synchronizable: KeychainItemAttributeSynchronizabilityValue) -> SelfReturnType {
        return setAttribute(synchronizable, forKey: .synchronizable)
    }
    
    func _setSecurityDomain(_ securityDomain: String) -> SelfReturnType {
        return setAttribute(securityDomain, forKey: .securityDomain)
    }
    
    func _setServer(_ server: String) -> SelfReturnType {
        return setAttribute(server, forKey: .server)
    }
    
    func _setProtocol(_ protocol: KeychainItemAttributeProtocolValue) -> SelfReturnType {
        return setAttribute(`protocol`, forKey: .protocol)
    }
    
    func _setAuthenticationType(_ authenticationType: KeychainItemAttributeAuthenticationTypeValue) -> SelfReturnType {
        return setAttribute(authenticationType, forKey: .authenticationType)
    }
    
    func _setPort(_ port: Int) -> SelfReturnType {
        let nsPort: NSNumber = .init(value: port)
        return setAttribute(nsPort, forKey: .port)
    }
    
    func _setPath(_ path: String) -> SelfReturnType {
        return setAttribute(path, forKey: .path)
    }
}

// MARK: - KeychainItemAttributesSettable with KeychainGenericPassword

extension KeychainItemAttributesSettable where KeychainClass == KeychainGenericPassword {
    
    public func setAccessControl(_ accessControl: SecAccessControl?) -> SelfReturnType {
        return _setAccessControl(accessControl)
    }
    
    public func setAccessGroup(_ accessGroup: String) -> SelfReturnType {
        return _setAccessGroup(accessGroup)
    }
    
    public func setAccessible(_ accessible: KeychainItemAttributeAccessibilityValue) -> SelfReturnType {
        return _setAccessible(accessible)
    }
    
    public func setCreationDate(_ creationDate: Date) -> SelfReturnType {
        return _setCreationDate(creationDate)
    }
    
    public func setModificationDate(_ modificationDate: Date) -> SelfReturnType {
        return _setModificationDate(modificationDate)
    }
    
    public func setDescription(_ description: String) -> SelfReturnType {
        return _setDescription(description)
    }
    
    public func setComment(_ comment: String) -> SelfReturnType {
        return _setComment(comment)
    }
    
    public func setCreator(_ creator: NSNumber) -> SelfReturnType {
        return _setCreator(creator)
    }
    
    public func setType(_ type: NSNumber) -> SelfReturnType {
        return _setType(type)
    }
    
    public func setLabel(_ label: String) -> SelfReturnType {
        return _setLabel(label)
    }
    
    public func setInvisible(_ isInvisible: Bool) -> SelfReturnType {
        return _setInvisible(isInvisible)
    }
    
    public func setNegative(_ isNegative: Bool) -> SelfReturnType {
        return _setNegative(isNegative)
    }
    
    public func setAccount(_ account: String) -> SelfReturnType {
        return _setAccount(account)
    }
    
    public func setService(_ service: String) -> SelfReturnType {
        return _setService(service)
    }
    
    public func setGeneric(_ generic: Data) -> SelfReturnType {
        return _setGeneric(generic)
    }
    
    public func setSynchronizable(_ synchronizable: KeychainItemAttributeSynchronizabilityValue) -> SelfReturnType {
        return _setSynchronizable(synchronizable)
    }
}

// MARK: - KeychainItemAttributesSettable with KeychainInternetPassword

extension KeychainItemAttributesSettable where KeychainClass == KeychainInternetPassword {
    
    public func setAccessGroup(_ accessGroup: String) -> SelfReturnType {
        return _setAccessGroup(accessGroup)
    }
    
    public func setAccessible(_ accessible: KeychainItemAttributeAccessibilityValue) -> SelfReturnType {
        return _setAccessible(accessible)
    }
    
    public func setCreationDate(_ creationDate: Date) -> SelfReturnType {
        return _setCreationDate(creationDate)
    }
    
    public func setModificationDate(_ modificationDate: Date) -> SelfReturnType {
        return _setModificationDate(modificationDate)
    }
    
    public func setDescription(_ description: String) -> SelfReturnType {
        return _setDescription(description)
    }
    
    public func setComment(_ comment: String) -> SelfReturnType {
        return _setComment(comment)
    }
    
    public func setCreator(_ creator: NSNumber) -> SelfReturnType {
        return _setCreator(creator)
    }
    
    public func setType(_ type: NSNumber) -> SelfReturnType {
        return _setType(type)
    }
    
    public func setLabel(_ label: String) -> SelfReturnType {
        return _setLabel(label)
    }
    
    public func setInvisible(_ isInvisible: Bool) -> SelfReturnType {
        return _setInvisible(isInvisible)
    }
    
    public func setNegative(_ isNegative: Bool) -> SelfReturnType {
        return _setNegative(isNegative)
    }
    
    public func setAccount(_ account: String) -> SelfReturnType {
        return _setAccount(account)
    }
    
    public func setSecurityDomain(_ securityDomain: String) -> SelfReturnType {
        return _setSecurityDomain(securityDomain)
    }
    
    public func setServer(_ server: String) -> SelfReturnType {
        return _setServer(server)
    }
    
    public func setProtocol(_ protocol: KeychainItemAttributeProtocolValue) -> SelfReturnType {
        return _setProtocol(`protocol`)
    }
    
    public func setAuthenticationType(_ authenticationType: KeychainItemAttributeAuthenticationTypeValue) -> SelfReturnType {
        return _setAuthenticationType(authenticationType)
    }
    
    public func setPort(_ port: Int) -> SelfReturnType {
        return _setPort(port)
    }
    
    public func setPath(_ path: String) -> SelfReturnType {
        return _setPath(path)
    }
    
    public func setSynchronizable(_ synchronizable: KeychainItemAttributeSynchronizabilityValue) -> SelfReturnType {
        return _setSynchronizable(synchronizable)
    }
}

// MARK: - KeychainItemAttributesSettable with KeychainCertificate

extension KeychainItemAttributesSettable where KeychainClass == KeychainCertificate {
    
    
}

// MARK: - KeychainItemAttributesSettable with KeychainKey

extension KeychainItemAttributesSettable where KeychainClass == KeychainKey {
    
    
}

// MARK: - KeychainItemAttributesSettable with KeychainIdentity

extension KeychainItemAttributesSettable where KeychainClass == KeychainIdentity {
    
    
}
