//
//  KeychainingNormalTests.swift
//  Keychaining_Tests
//
//  Created by Jaewon Yun on 2023/03/18.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import Keychaining

final class KeychainingNormalTests: XCTestCase {
    
    override func setUp() async throws {
        try await deleteAll()
    }
    
    override func tearDown() async throws {
        try await deleteAll()
    }
    
    // [저장 -> 업데이트 -> 검색 -> 삭제] 순서대로 테스트를 수행합니다.
    func testGenericPassword() async {
        // Common Arrange
        let service = "Service"
        let account = "Account"
        let newAccount = "NewAccount"
        let passwordData = "1234".data(using: .utf8)!
        let newPasswordData = "567890".data(using: .utf8)!
        let label = "Label"
        let defaultQuery = Keychain.genericPassword.makeBasicQuery()
            .setService(service)
            .setAccount(account)
        
    saveData:
        do {
            // Arrange
            let saveQuery = defaultQuery.forSave
                .setLabel(label)
                .setValueType(.data(passwordData), forKey: .valueData)
            
            // Act
            do { try await saveQuery.execute() }
            
            // Assert
            catch { XCTFail("저장 실패. \(error)") }
        }
        
    updateAccountAndData:
        do {
            // Arrange
            let updateQuery = defaultQuery.forUpdate
                .setLabel(label) // Intended duplicate setting.
                .setAttribute(.init(rawValue: newAccount), toUpdateForKey: .account)
                .setValueType(.data(newPasswordData), toUpdateForKey: .valueData)
            
            // Act
            do { try await updateQuery.execute() }
            
            // Assert
            catch { XCTFail("업데이트 실패. \(error)") }
        }
        
    searchDataForUpdatedAccount:
        do {
            // Arrange
            let searchQuery = defaultQuery.forSearch
                .setAccount(newAccount)
                .setReturnType(true, forKey: .returnData)
            
            // Act
            do {
                let data = try await searchQuery.execute()
                XCTAssertEqual(data, newPasswordData)
            }
            
            // Assert
            catch { XCTFail("검색 실패. \(error)") }
        }
        
    deleteData:
        do {
            // Arrange
            let deleteQuery = defaultQuery.forDelete
                .setAccount(newAccount)
            
            // Act
            do { try await deleteQuery.execute() }
            
            // Assert
            catch { XCTFail("삭제 실패. \(error)") }
            let data = try? await defaultQuery.forSearch.setAccount(newAccount).execute()
            XCTAssertNil(data)
        }
    }
    
    func testInternetPasswordUseOnlyDictionaryFeature() {
        // Common Arrange
        let server = "Server"
        let account = "Account"
        let newAccount = "NewAccount"
        let passwordData = "1234".data(using: .utf8)!
        let newPasswordData = "567890".data(using: .utf8)!
        let label = "Label"
        
    saveData:
        do {
            // Arrange
            let query = Keychain.makeDictionary()
                .setClass(.internetPassword)
                .setAttribute(server, forKey: .server)
                .setAttribute(account, forKey: .account)
                .setAttribute(label, forKey: .label)
                .setValueType(.data(passwordData), forKey: .valueData)
                .asCFDictionary()
            
            // Act
            let status = SecItemAdd(query, nil)
            
            // Assert
            if status.asKeychainStatus != .success {
                XCTFail("저장 실패. \(status.toReadableString!)")
            }
        }
        
    updateAccountAndData:
        do {
            // Arrange
            let query = Keychain.makeDictionary()
                .setClass(.internetPassword)
                .setAttribute(server, forKey: .server)
                .setAttribute(account, forKey: .account)
                .setAttribute(label, forKey: .label)
                .asCFDictionary()
            
            let attributesToUpdate = Keychain.makeDictionary()
                .setAttribute(newAccount, forKey: .account)
                .setValueType(.data(newPasswordData), forKey: .valueData)
                .asCFDictionary()
            
            // Act
            let status = SecItemUpdate(query, attributesToUpdate)
            
            // Assert
            if status.asKeychainStatus != .success {
                XCTFail("업데이트 실패. \(status.toReadableString!)")
            }
        }
        
    searchDataForUpdatedAccount:
        do {
            // Arrange
            let query = Keychain.makeDictionary()
                .setClass(.internetPassword)
                .setAttribute(server, forKey: .server)
                .setAttribute(newAccount, forKey: .account)
                .setAttribute(label, forKey: .label)
                .setReturnType(true, forKey: .returnData)
                .asCFDictionary()
            var result: AnyObject? = nil
            
            // Act
            let status = SecItemCopyMatching(query, &result)
            
            // Assert
            if status.asKeychainStatus != .success {
                XCTFail("검색 실패. \(status.toReadableString!)")
            }
            XCTAssertEqual(result as? Data, newPasswordData)
        }
        
    deleteData:
        do {
            // Arrange
            let deleteQuery = Keychain.makeDictionary()
                .setClass(.internetPassword)
                .setAttribute(server, forKey: .server)
                .asCFDictionary()
            let searchQuery = Keychain.makeDictionary()
                .setClass(.internetPassword)
                .setAttribute(server, forKey: .server)
                .setAttribute(newAccount, forKey: .account)
                .setAttribute(label, forKey: .label)
                .setReturnType(true, forKey: .returnData)
                .asCFDictionary()
            var result: AnyObject? = nil
            
            // Act
            let deleteStatus = SecItemDelete(deleteQuery)
            
            // Assert
            if deleteStatus.asKeychainStatus != .success {
                XCTFail("삭제 실패. \(deleteStatus.toReadableString!)")
            }
            
            SecItemCopyMatching(searchQuery, &result)
            XCTAssertNil(result)
        }
    }
    
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
        let generic: Data = .init()
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
}

// MARK: - Helper Methods

private extension KeychainingNormalTests {
    
    func deleteAll() async throws {
        try await Keychain.genericPassword.makeDeleteQuery().execute()
        try await Keychain.internetPassword.makeDeleteQuery().execute()
        try await Keychain.key.makeDeleteQuery().execute()
        try await Keychain.certificate.makeDeleteQuery().execute()
        try await Keychain.identity.makeDeleteQuery().execute()
    }
}
