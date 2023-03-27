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
            .setAttribute(service, forKey: .service)
            .setAttribute(account, forKey: .account)
        
    saveData:
        do {
            // Arrange
            let saveQuery = defaultQuery.forSave
                .setAttribute(label, forKey: .label)
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
                .setAttribute(label, forKey: .label) // Intended duplicate setting.
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
                .setAttribute(newAccount, forKey: .account)
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
                .setAttribute(newAccount, forKey: .account)
            
            // Act
            do { try await deleteQuery.execute() }
            
            // Assert
            catch { XCTFail("삭제 실패. \(error)") }
            let data = try? await defaultQuery.forSearch.setAttribute(newAccount, forKey: .account).execute()
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
            
            let searchStatus = SecItemCopyMatching(searchQuery, &result)
            XCTAssertNil(result)
        }
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
