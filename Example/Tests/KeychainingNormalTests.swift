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
        let defaultQuery = Keychain.genericPassword.makeQuery()
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
