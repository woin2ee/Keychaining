//
//  KeychainAttributes.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/29.
//

import Foundation

public protocol KeychainItemAttributesSettable: UpdatedSelfCreatable {
    
    associatedtype AttributesType: KeychainCommonItemAttributes
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> Self
    
    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> Self
    
}

// MARK: - All private methods to set the attribute.

private extension KeychainItemAttributesSettable {
    
    // TODO: SecAccessControl 생성 API 제공
    func _setAccessControl(_ accessControl: SecAccessControl?) -> Self {
        return setAttribute(accessControl, forKey: .accessControl)
    }
    
    func _setAccessGroup(_ accessGroup: KeychainItemAttributeAccessGroupValue) -> Self {
        return setAttribute(accessGroup, forKey: .accessGroup)
    }
    
    func _setAccessible(_ accessible: KeychainItemAttributeAccessibilityValue) -> Self {
        return setAttribute(accessible, forKey: .accessible)
    }
    
    func _setCreationDate(_ creationDate: Date) -> Self {
        return setAttribute(creationDate, forKey: .creationDate)
    }
    
    func _setModificationDate(_ modificationDate: Date) -> Self {
        return setAttribute(modificationDate, forKey: .modificationDate)
    }
    
    func _setDescription(_ description: String) -> Self {
        return setAttribute(description, forKey: .description)
    }
    
    func _setComment(_ comment: String) -> Self {
        return setAttribute(comment, forKey: .comment)
    }
    
    func _setCreator(_ creator: NSNumber) -> Self { // 4바이트 문자 코드 (ex. (abcd) == 0x61626364 == 1633837924)
        return setAttribute(creator, forKey: .creator)
    }
    
    func _setType(_ type: NSNumber) -> Self { // 4바이트 문자 코드 (ex. (abcd) == 0x61626364 == 1633837924)
        return setAttribute(type, forKey: .type)
    }
    
    func _setLabel(_ label: String) -> Self {
        return setAttribute(label, forKey: .label)
    }
    
    func _setApplicationLabel(_ applicationLabel: Data) -> Self {
        return setAttribute(applicationLabel, forKey: .applicationLabel)
    }
    
    func _setInvisible(_ isInvisible: Bool) -> Self {
        return setAttribute(isInvisible, forKey: .isInvisible)
    }
    
    func _setNegative(_ isNegative: Bool) -> Self {
        return setAttribute(isNegative, forKey: .isNegative)
    }
    
    func _setAccount(_ account: String) -> Self {
        return setAttribute(account, forKey: .account)
    }
    
    func _setService(_ service: String) -> Self {
        return setAttribute(service, forKey: .service)
    }
    
    func _setGeneric(_ generic: Data) -> Self {
        return setAttribute(generic, forKey: .generic)
    }
    
    func _setSynchronizable(_ synchronizable: KeychainItemAttributeSynchronizabilityValue) -> Self {
        return setAttribute(synchronizable, forKey: .synchronizable)
    }
    
    func _setSecurityDomain(_ securityDomain: String) -> Self {
        return setAttribute(securityDomain, forKey: .securityDomain)
    }
    
    func _setServer(_ server: String) -> Self {
        return setAttribute(server, forKey: .server)
    }
    
    func _setProtocol(_ protocol: KeychainItemAttributeProtocolValue) -> Self {
        return setAttribute(`protocol`, forKey: .protocol)
    }
    
    func _setAuthenticationType(_ authenticationType: KeychainItemAttributeAuthenticationTypeValue) -> Self {
        return setAttribute(authenticationType, forKey: .authenticationType)
    }
    
    func _setPort(_ port: Int) -> Self {
        return setAttribute(port as NSNumber, forKey: .port)
    }
    
    func _setPath(_ path: String) -> Self {
        return setAttribute(path, forKey: .path)
    }
    
    func _setKeyClass(_ keyClass: KeychainItemAttributeKeyClassValue) -> Self { // 읽기전용???
        return setAttribute(keyClass, forKey: .keyClass)
    }
    
    func _setPermanent(_ isPermanent: Bool) -> Self {
        return setAttribute(isPermanent, forKey: .isPermanent)
    }
    
    func _setApplicationTag(_ applicationTag: Data) -> Self {
        return setAttribute(applicationTag, forKey: .applicationTag)
    }
    
    func _setKeyType(_ keyType: KeychainItemAttributeKeyTypeValue) -> Self {
        return setAttribute(keyType, forKey: .keyType)
    }
    
    func _setKeySizeInBits(_ keySizeInBits: Int) -> Self {
        return setAttribute(keySizeInBits as NSNumber, forKey: .keySizeInBits)
    }
    
    func _setEffectiveKeySize(_ effectiveKeySize: Int) -> Self {
        return setAttribute(effectiveKeySize as NSNumber, forKey: .effectiveKeySize)
    }
    
    func _setEncryptable(_ canEncrypt: Bool) -> Self {
        return setAttribute(canEncrypt, forKey: .canEncrypt)
    }
    
    func _setDecryptable(_ canDecrypt: Bool) -> Self {
        return setAttribute(canDecrypt, forKey: .canDecrypt)
    }
    
    func _setDerivable(_ canDerive: Bool) -> Self {
        return setAttribute(canDerive, forKey: .canDerive)
    }
    
    func _setSignable(_ canSign: Bool) -> Self {
        return setAttribute(canSign, forKey: .canSign)
    }
    
    func _setVerifiable(_ canVerify: Bool) -> Self {
        return setAttribute(canVerify, forKey: .canVerify)
    }
    
    func _setWrappable(_ canWrap: Bool) -> Self {
        return setAttribute(canWrap, forKey: .canWrap)
    }
    
    func _setUnwrappable(_ canUnwrap: Bool) -> Self {
        return setAttribute(canUnwrap, forKey: .canUnwrap)
    }
    
}

// MARK: - KeychainCommonItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainCommonItemAttributes {
    
    public func setAccessGroup(_ accessGroup: KeychainItemAttributeAccessGroupValue) -> Self {
        return _setAccessGroup(accessGroup)
    }
    
    public func setAccessGroup(_ accessGroup: String) -> Self {
        return _setAccessGroup("\(accessGroup)")
    }
    
    public func setAccessible(_ accessible: KeychainItemAttributeAccessibilityValue) -> Self {
        return _setAccessible(accessible)
    }
    
    public func setLabel(_ label: String) -> Self {
        return _setLabel(label)
    }
}

// MARK: - KeychainGenericPasswordItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainGenericPasswordItemAttributes {
    
    public func setAccessControl(_ accessControl: SecAccessControl?) -> Self {
        return _setAccessControl(accessControl)
    }
    
    public func setCreationDate(_ creationDate: Date) -> Self {
        return _setCreationDate(creationDate)
    }
    
    public func setModificationDate(_ modificationDate: Date) -> Self {
        return _setModificationDate(modificationDate)
    }
    
    public func setDescription(_ description: String) -> Self {
        return _setDescription(description)
    }
    
    public func setComment(_ comment: String) -> Self {
        return _setComment(comment)
    }
    
    public func setCreator(_ creator: NSNumber) -> Self {
        return _setCreator(creator)
    }
    
    public func setType(_ type: NSNumber) -> Self {
        return _setType(type)
    }
    
    public func setInvisible(_ isInvisible: Bool) -> Self {
        return _setInvisible(isInvisible)
    }
    
    public func setNegative(_ isNegative: Bool) -> Self {
        return _setNegative(isNegative)
    }
    
    public func setAccount(_ account: String) -> Self {
        return _setAccount(account)
    }
    
    public func setService(_ service: String) -> Self {
        return _setService(service)
    }
    
    public func setGeneric(_ generic: Data) -> Self {
        return _setGeneric(generic)
    }
    
    public func setSynchronizable(_ synchronizable: KeychainItemAttributeSynchronizabilityValue) -> Self {
        return _setSynchronizable(synchronizable)
    }
    
}

// MARK: - KeychainInternetPasswordItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainInternetPasswordItemAttributes {
    
    public func setCreationDate(_ creationDate: Date) -> Self {
        return _setCreationDate(creationDate)
    }
    
    public func setModificationDate(_ modificationDate: Date) -> Self {
        return _setModificationDate(modificationDate)
    }
    
    public func setDescription(_ description: String) -> Self {
        return _setDescription(description)
    }
    
    public func setComment(_ comment: String) -> Self {
        return _setComment(comment)
    }
    
    public func setCreator(_ creator: NSNumber) -> Self {
        return _setCreator(creator)
    }
    
    public func setType(_ type: NSNumber) -> Self {
        return _setType(type)
    }
    
    public func setInvisible(_ isInvisible: Bool) -> Self {
        return _setInvisible(isInvisible)
    }
    
    public func setNegative(_ isNegative: Bool) -> Self {
        return _setNegative(isNegative)
    }
    
    public func setAccount(_ account: String) -> Self {
        return _setAccount(account)
    }
    
    public func setSecurityDomain(_ securityDomain: String) -> Self {
        return _setSecurityDomain(securityDomain)
    }
    
    public func setServer(_ server: String) -> Self {
        return _setServer(server)
    }
    
    public func setProtocol(_ protocol: KeychainItemAttributeProtocolValue) -> Self {
        return _setProtocol(`protocol`)
    }
    
    public func setAuthenticationType(_ authenticationType: KeychainItemAttributeAuthenticationTypeValue) -> Self {
        return _setAuthenticationType(authenticationType)
    }
    
    public func setPort(_ port: Int) -> Self {
        return _setPort(port)
    }
    
    public func setPath(_ path: String) -> Self {
        return _setPath(path)
    }
    
    public func setSynchronizable(_ synchronizable: KeychainItemAttributeSynchronizabilityValue) -> Self {
        return _setSynchronizable(synchronizable)
    }
    
}

// MARK: - KeychainCertificateItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainCertificateItemAttributes {}

// MARK: - KeychainKeyItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainKeyItemAttributes {
    
    public func setKeyClass(_ keyClass: KeychainItemAttributeKeyClassValue) -> Self {
        return _setKeyClass(keyClass)
    }
    
    public func setApplicationLabel(_ applicationLabel: Data) -> Self {
        return _setApplicationLabel(applicationLabel)
    }
    
    public func setPermanent(_ isPermanent: Bool) -> Self {
        return _setPermanent(isPermanent)
    }
    
    public func setApplicationTag(_ applicationTag: Data) -> Self {
        return _setApplicationTag(applicationTag)
    }
    
    public func setKeyType(_ keyType: KeychainItemAttributeKeyTypeValue) -> Self {
        return _setKeyType(keyType)
    }
    
    public func setKeySizeInBits(_ keySizeInBits: Int) -> Self {
        return _setKeySizeInBits(keySizeInBits)
    }
    
    public func setEffectiveKeySize(_ effectiveKeySize: Int) -> Self {
        return _setEffectiveKeySize(effectiveKeySize)
    }
    
    public func setEncryptable(_ canEncrypt: Bool) -> Self {
        return _setEncryptable(canEncrypt)
    }
    
    public func setDecryptable(_ canDecrypt: Bool) -> Self {
        return _setDecryptable(canDecrypt)
    }
    
    public func setDerivable(_ canDerive: Bool) -> Self {
        return _setDerivable(canDerive)
    }
    
    public func setSignable(_ canSign: Bool) -> Self {
        return _setSignable(canSign)
    }
    
    public func setVerifiable(_ canVerify: Bool) -> Self {
        return _setVerifiable(canVerify)
    }
    
    public func setWrappable(_ canWrap: Bool) -> Self {
        return _setWrappable(canWrap)
    }
    
    public func setUnwrappable(_ canUnwrap: Bool) -> Self {
        return _setUnwrappable(canUnwrap)
    }
    
}

// MARK: - KeychainIdentityItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainIdentityItemAttributes {}
