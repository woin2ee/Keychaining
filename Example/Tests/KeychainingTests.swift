//
//  KeychainingTests.swift
//  Keychaining_Tests
//
//  Created by Jaewon Yun on 2023/03/18.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import Keychaining

final class KeychainingTests: XCTestCase {
    
    var serviceNameUnderTest: String {
        "Service"
    }
    var deleteAllQuery: KeychainDeleteQuery {
        Keychain.genericPassword.makeDeleteQuery()
            .setAttribute(.init(rawValue: serviceNameUnderTest), forKey: .service)
    }
    
    override func setUp() async throws {
        try await deleteAllQuery.execute()
    }
    
    override func tearDown() async throws {
        try await deleteAllQuery.execute()
    }
    
    func testSaveItem() async throws {
        // Arrange
        let account = "Account"
        let passwordData = "1234".data(using: .utf8)!
        let query = Keychain.genericPassword.makeQuery()
            .setAttribute(.init(rawValue: serviceNameUnderTest), forKey: .service)
            .setAttribute(.init(rawValue: account), forKey: .account)
        let saveQuery = query.forSave
            .setValueType(.data(passwordData), forKey: .valueData)
        let searchQuery = query.forSearch
            .setReturnType(.true, forKey: .returnData)
        
        // Act
        try await saveQuery.execute()
        
        // Assert
        let savedData = try await searchQuery.execute()
        XCTAssertEqual(passwordData, savedData)
    }
    
    func testUpdateItem() async throws {
//        try await Keychain.genericPassword.makeUpdateQuery()
////            .setAttribute(<#T##attribute: KeychainItemAttributeValue##KeychainItemAttributeValue#>, forKey: <#T##KeychainItemAttributeKey#>)
//            .execute()
    }
    
    func testGetItem() {
        
    }
    
    func testDeleteItem() {
        
    }
    
    func testAnySome() {
//        let saveQuery = Keychain.genericPassword.makeSaveQuery()
//        let searchQuery = Keychain.genericPassword.makeSearchQuery()
//
//        let queries = [saveQuery, searchQuery].compactMap { $0 as? any KeychainQueryExecutable }
//
//        func execute(query: some QueryExecutable) -> Void {
//            Task {
//                try? await query.execute()
//            }
//        }
//
//        queries.forEach { query in
//            execute(query: query)
//        }
    }
}
