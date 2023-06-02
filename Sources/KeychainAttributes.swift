//
//  KeychainAttributes.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/29.
//

import Foundation

public protocol KeychainItemAttributesSettable: SelfReturnable {
    
    associatedtype AttributesType: KeychainCommonItemAttributes
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> SelfReturnType
    
    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> SelfReturnType
    
}

// MARK: - All private methods to set the attribute.

private extension KeychainItemAttributesSettable {
    
    // TODO: SecAccessControl 생성 API 제공
    func _setAccessControl(_ accessControl: SecAccessControl?) -> SelfReturnType {
        return setAttribute(accessControl, forKey: .accessControl)
    }
    
    func _setAccessGroup(_ accessGroup: KeychainItemAttributeAccessGroupValue) -> SelfReturnType {
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
    
    func _setApplicationLabel(_ applicationLabel: Data) -> SelfReturnType {
        return setAttribute(applicationLabel, forKey: .applicationLabel)
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
        return setAttribute(port as NSNumber, forKey: .port)
    }
    
    func _setPath(_ path: String) -> SelfReturnType {
        return setAttribute(path, forKey: .path)
    }
    
    func _setKeyClass(_ keyClass: KeychainItemAttributeKeyClassValue) -> SelfReturnType { // 읽기전용???
        return setAttribute(keyClass, forKey: .keyClass)
    }
    
    func _setPermanent(_ isPermanent: Bool) -> SelfReturnType {
        return setAttribute(isPermanent, forKey: .isPermanent)
    }
    
    func _setApplicationTag(_ applicationTag: Data) -> SelfReturnType {
        return setAttribute(applicationTag, forKey: .applicationTag)
    }
    
    func _setKeyType(_ keyType: KeychainItemAttributeKeyTypeValue) -> SelfReturnType {
        return setAttribute(keyType, forKey: .keyType)
    }
    
    func _setKeySizeInBits(_ keySizeInBits: Int) -> SelfReturnType {
        return setAttribute(keySizeInBits as NSNumber, forKey: .keySizeInBits)
    }
    
    func _setEffectiveKeySize(_ effectiveKeySize: Int) -> SelfReturnType {
        return setAttribute(effectiveKeySize as NSNumber, forKey: .effectiveKeySize)
    }
    
    func _setEncryptable(_ canEncrypt: Bool) -> SelfReturnType {
        return setAttribute(canEncrypt, forKey: .canEncrypt)
    }
    
    func _setDecryptable(_ canDecrypt: Bool) -> SelfReturnType {
        return setAttribute(canDecrypt, forKey: .canDecrypt)
    }
    
    func _setDerivable(_ canDerive: Bool) -> SelfReturnType {
        return setAttribute(canDerive, forKey: .canDerive)
    }
    
    func _setSignable(_ canSign: Bool) -> SelfReturnType {
        return setAttribute(canSign, forKey: .canSign)
    }
    
    func _setVerifiable(_ canVerify: Bool) -> SelfReturnType {
        return setAttribute(canVerify, forKey: .canVerify)
    }
    
    func _setWrappable(_ canWrap: Bool) -> SelfReturnType {
        return setAttribute(canWrap, forKey: .canWrap)
    }
    
    func _setUnwrappable(_ canUnwrap: Bool) -> SelfReturnType {
        return setAttribute(canUnwrap, forKey: .canUnwrap)
    }
    
}

// MARK: - KeychainCommonItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainCommonItemAttributes {
    
    public func setAccessGroup(_ accessGroup: KeychainItemAttributeAccessGroupValue) -> SelfReturnType {
        return _setAccessGroup(accessGroup)
    }
    
    public func setAccessGroup(_ accessGroup: String) -> SelfReturnType {
        return _setAccessGroup("\(accessGroup)")
    }
    
    public func setAccessible(_ accessible: KeychainItemAttributeAccessibilityValue) -> SelfReturnType {
        return _setAccessible(accessible)
    }
    
    public func setLabel(_ label: String) -> SelfReturnType {
        return _setLabel(label)
    }
}

// MARK: - KeychainGenericPasswordItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainGenericPasswordItemAttributes {
    
    public func setAccessControl(_ accessControl: SecAccessControl?) -> SelfReturnType {
        return _setAccessControl(accessControl)
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

// MARK: - KeychainInternetPasswordItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainInternetPasswordItemAttributes {
    
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

// MARK: - KeychainCertificateItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainCertificateItemAttributes {}

// MARK: - KeychainKeyItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainKeyItemAttributes {
    
    public func setKeyClass(_ keyClass: KeychainItemAttributeKeyClassValue) -> SelfReturnType {
        return _setKeyClass(keyClass)
    }
    
    public func setApplicationLabel(_ applicationLabel: Data) -> SelfReturnType {
        return _setApplicationLabel(applicationLabel)
    }
    
    public func setPermanent(_ isPermanent: Bool) -> SelfReturnType {
        return _setPermanent(isPermanent)
    }
    
    public func setApplicationTag(_ applicationTag: Data) -> SelfReturnType {
        return _setApplicationTag(applicationTag)
    }
    
    public func setKeyType(_ keyType: KeychainItemAttributeKeyTypeValue) -> SelfReturnType {
        return _setKeyType(keyType)
    }
    
    public func setKeySizeInBits(_ keySizeInBits: Int) -> SelfReturnType {
        return _setKeySizeInBits(keySizeInBits)
    }
    
    public func setEffectiveKeySize(_ effectiveKeySize: Int) -> SelfReturnType {
        return _setEffectiveKeySize(effectiveKeySize)
    }
    
    public func setEncryptable(_ canEncrypt: Bool) -> SelfReturnType {
        return _setEncryptable(canEncrypt)
    }
    
    public func setDecryptable(_ canDecrypt: Bool) -> SelfReturnType {
        return _setDecryptable(canDecrypt)
    }
    
    public func setDerivable(_ canDerive: Bool) -> SelfReturnType {
        return _setDerivable(canDerive)
    }
    
    public func setSignable(_ canSign: Bool) -> SelfReturnType {
        return _setSignable(canSign)
    }
    
    public func setVerifiable(_ canVerify: Bool) -> SelfReturnType {
        return _setVerifiable(canVerify)
    }
    
    public func setWrappable(_ canWrap: Bool) -> SelfReturnType {
        return _setWrappable(canWrap)
    }
    
    public func setUnwrappable(_ canUnwrap: Bool) -> SelfReturnType {
        return _setUnwrappable(canUnwrap)
    }
    
}

// MARK: - KeychainIdentityItemAttributes

extension KeychainItemAttributesSettable where AttributesType: KeychainIdentityItemAttributes {}
