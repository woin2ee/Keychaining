//
//  AttributeSettingMethodsTests.swift
//  Keychaining_Tests
//
//  Created by Jaewon Yun on 2023/04/20.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import Keychaining

final class AttributeSettingMethodsTests: XCTestCase {
    
    func testGenericPasswordAttributesSetMethods() {
        // Arrange
        let accessControl = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            SecAccessControlCreateFlags(),
            nil
        )
        let accessGroup = "AccessGroup"
        let accessible: KeychainItemAttributeAccessibilityValue = .whenUnlocked
        let creationDate: Date = .init()
        let modificationDate: Date = .init()
        let description = "Description"
        let comment = "Comment"
        let creator: NSNumber = 1633837924
        let type: NSNumber = 1633837924
        let label = "Label"
        let isInvisible = true
        let isNegative = true
        let account = "Account"
        let service = "Service"
        let generic: Data = "Generic".data(using: .utf8)!
        let synchronizable: KeychainItemAttributeSynchronizabilityValue = .any
        
        // Act
        let cfDictionary = Keychain.genericPassword.makeBasicQuery()
            .setAccessControl(accessControl)
            .setAccessGroup(accessGroup)
            .setAccessible(accessible)
            .setCreationDate(creationDate)
            .setModificationDate(modificationDate)
            .setDescription(description)
            .setComment(comment)
            .setCreator(creator)
            .setType(type)
            .setLabel(label)
            .setInvisible(isInvisible)
            .setNegative(isNegative)
            .setAccount(account)
            .setService(service)
            .setGeneric(generic)
            .setSynchronizable(synchronizable)
            .asCFDictionary() as! [CFString: Any]
        
        // Assert
        XCTAssertEqual((cfDictionary[kSecAttrAccessControl] as! SecAccessControl), accessControl)
        XCTAssertEqual(cfDictionary[kSecAttrAccessGroup] as? String, accessGroup)
        XCTAssertEqual(cfDictionary[kSecAttrAccessible] as! CFString, accessible.rawValue as! CFString)
        XCTAssertEqual(cfDictionary[kSecAttrCreationDate] as? Date, creationDate)
        XCTAssertEqual(cfDictionary[kSecAttrModificationDate] as? Date, modificationDate)
        XCTAssertEqual(cfDictionary[kSecAttrDescription] as? String, description)
        XCTAssertEqual(cfDictionary[kSecAttrComment] as? String, comment)
        XCTAssertEqual(cfDictionary[kSecAttrCreator] as? NSNumber, creator)
        XCTAssertEqual(cfDictionary[kSecAttrType] as? NSNumber, type)
        XCTAssertEqual(cfDictionary[kSecAttrLabel] as? String, label)
        XCTAssertEqual(cfDictionary[kSecAttrIsInvisible] as? Bool, isInvisible)
        XCTAssertEqual(cfDictionary[kSecAttrIsNegative] as? Bool, isNegative)
        XCTAssertEqual(cfDictionary[kSecAttrAccount] as? String, account)
        XCTAssertEqual(cfDictionary[kSecAttrService] as? String, service)
        XCTAssertEqual(cfDictionary[kSecAttrGeneric] as? Data, generic)
        XCTAssertEqual(cfDictionary[kSecAttrSynchronizable] as! CFString, synchronizable.rawValue as! CFString)
    }
    
    func testInternetPasswordAttributesSetMethods() {
        // Arrange
        let accessGroup = "AccessGroup"
        let accessible: KeychainItemAttributeAccessibilityValue = .whenPasscodeSetThisDeviceOnly
        let creationDate: Date = .init()
        let modificationDate: Date = .init()
        let description = "Description"
        let comment = "Comment"
        let creator: NSNumber = 1633837924
        let type: NSNumber = 1633837924
        let label = "Label"
        let isInvisible = false
        let isNegative = false
        let account = "Account"
        let securityDomain = "SecurityDomain"
        let server = "Server"
        let `protocol`: KeychainItemAttributeProtocolValue = .ftp
        let authenticationType: KeychainItemAttributeAuthenticationTypeValue = .ntlm
        let port = 12345
        let path = "Path"
        let synchronizable: KeychainItemAttributeSynchronizabilityValue = .true
        
        // Act
        let cfDictionary = Keychain.internetPassword.makeBasicQuery()
            .setAccessGroup(accessGroup)
            .setAccessible(accessible)
            .setCreationDate(creationDate)
            .setModificationDate(modificationDate)
            .setDescription(description)
            .setComment(comment)
            .setCreator(creator)
            .setType(type)
            .setLabel(label)
            .setInvisible(isInvisible)
            .setNegative(isNegative)
            .setAccount(account)
            .setSecurityDomain(securityDomain)
            .setServer(server)
            .setProtocol(`protocol`)
            .setAuthenticationType(authenticationType)
            .setPort(port)
            .setPath(path)
            .setSynchronizable(synchronizable)
            .asCFDictionary() as! [CFString: Any]
        
        // Assert
        XCTAssertEqual(cfDictionary[kSecAttrAccessGroup] as? String, accessGroup)
        XCTAssertEqual(cfDictionary[kSecAttrAccessible] as! CFString, accessible.rawValue as! CFString)
        XCTAssertEqual(cfDictionary[kSecAttrCreationDate] as? Date, creationDate)
        XCTAssertEqual(cfDictionary[kSecAttrModificationDate] as? Date, modificationDate)
        XCTAssertEqual(cfDictionary[kSecAttrDescription] as? String, description)
        XCTAssertEqual(cfDictionary[kSecAttrComment] as? String, comment)
        XCTAssertEqual(cfDictionary[kSecAttrCreator] as? NSNumber, creator)
        XCTAssertEqual(cfDictionary[kSecAttrType] as? NSNumber, type)
        XCTAssertEqual(cfDictionary[kSecAttrLabel] as? String, label)
        XCTAssertEqual(cfDictionary[kSecAttrIsInvisible] as? Bool, isInvisible)
        XCTAssertEqual(cfDictionary[kSecAttrIsNegative] as? Bool, isNegative)
        XCTAssertEqual(cfDictionary[kSecAttrAccount] as? String, account)
        XCTAssertEqual(cfDictionary[kSecAttrSecurityDomain] as? String, securityDomain)
        XCTAssertEqual(cfDictionary[kSecAttrServer] as? String, server)
        XCTAssertEqual(cfDictionary[kSecAttrProtocol] as! CFString, `protocol`.rawValue as! CFString)
        XCTAssertEqual(cfDictionary[kSecAttrAuthenticationType] as! CFString, authenticationType.rawValue as! CFString)
        XCTAssertEqual(cfDictionary[kSecAttrPort] as? NSNumber, NSNumber.init(value: port))
        XCTAssertEqual(cfDictionary[kSecAttrPath] as? String, path)
        XCTAssertEqual(cfDictionary[kSecAttrSynchronizable] as! CFString, synchronizable.rawValue as! CFString)
    }
    
    func testIdentityAttributesSetMethods() {
        // Arrange
        let accessGroup: KeychainItemAttributeAccessGroupValue = .token
        let accessible: KeychainItemAttributeAccessibilityValue = .afterFirstUnlock
        let label = "Label"
        let keyClass: KeychainItemAttributeKeyClassValue = .symmetric
        let applicationLabel: Data = "ApplicationLabel".data(using: .utf8)!
        let isPermanent = true
        let applicationTag: Data = "ApplicationTag".data(using: .utf8)!
        let keyType: KeychainItemAttributeKeyTypeValue = .ecSecPrimeRandom
        let keySizeInBits: Int = 2048
        let effectiveKeySize: Int = 1024
        let canEncrypt = true
        let canDecrypt = false
        let canDerive = true
        let canSign = false
        let canVerify = true
        let canWrap = false
        let canUnwrap = true

        // Act
        let cfDictionary = Keychain.identity.makeBasicQuery()
            .setAccessGroup(accessGroup)
            .setAccessible(accessible)
            .setLabel(label)
            .setKeyClass(keyClass)
            .setApplicationLabel(applicationLabel)
            .setPermanent(isPermanent)
            .setApplicationTag(applicationTag)
            .setKeyType(keyType)
            .setKeySizeInBits(keySizeInBits)
            .setEffectiveKeySize(effectiveKeySize)
            .setEncryptable(canEncrypt)
            .setDecryptable(canDecrypt)
            .setDerivable(canDerive)
            .setSignable(canSign)
            .setVerifiable(canVerify)
            .setWrappable(canWrap)
            .setUnwrappable(canUnwrap)
            .asCFDictionary() as! [CFString: Any]

        // Assert
        XCTAssertEqual(cfDictionary[kSecAttrAccessGroup] as! CFString, accessGroup.rawValue as! CFString)
        XCTAssertEqual(cfDictionary[kSecAttrAccessible] as! CFString, accessible.rawValue as! CFString)
        XCTAssertEqual(cfDictionary[kSecAttrLabel] as! CFString, label as CFString)
        XCTAssertEqual(cfDictionary[kSecAttrKeyClass] as! CFString, keyClass.rawValue as! CFString)
        XCTAssertEqual(cfDictionary[kSecAttrApplicationLabel] as! CFData, applicationLabel as CFData)
        XCTAssertEqual(cfDictionary[kSecAttrIsPermanent] as! CFBoolean, isPermanent as CFBoolean)
        XCTAssertEqual(cfDictionary[kSecAttrApplicationTag] as! CFData, applicationTag as CFData)
        XCTAssertEqual(cfDictionary[kSecAttrKeyType] as! CFString, keyType.rawValue as! CFString)
        XCTAssertEqual(cfDictionary[kSecAttrKeySizeInBits] as! CFNumber, keySizeInBits as CFNumber)
        XCTAssertEqual(cfDictionary[kSecAttrEffectiveKeySize] as! CFNumber, effectiveKeySize as CFNumber)
        XCTAssertEqual(cfDictionary[kSecAttrCanEncrypt] as! CFBoolean, canEncrypt as CFBoolean)
        XCTAssertEqual(cfDictionary[kSecAttrCanDecrypt] as! CFBoolean, canDecrypt as CFBoolean)
        XCTAssertEqual(cfDictionary[kSecAttrCanDerive] as! CFBoolean, canDerive as CFBoolean)
        XCTAssertEqual(cfDictionary[kSecAttrCanSign] as! CFBoolean, canSign as CFBoolean)
        XCTAssertEqual(cfDictionary[kSecAttrCanVerify] as! CFBoolean, canVerify as CFBoolean)
        XCTAssertEqual(cfDictionary[kSecAttrCanWrap] as! CFBoolean, canWrap as CFBoolean)
        XCTAssertEqual(cfDictionary[kSecAttrCanUnwrap] as! CFBoolean, canUnwrap as CFBoolean)
        
        
        
    }
}
