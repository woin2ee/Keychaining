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
    
    func testSaveItem() async throws {
        let serviceName = Bundle.main.bundleIdentifier
        let query = Keychain.genericPassword.makeSaveQuery()
            .setAttribute(serviceName, forKey: .service)
        
        try await query
            
//            .setAttribute(<#T##attribute: KeychainItemAttributeValue##KeychainItemAttributeValue#>, forKey: <#T##KeychainItemAttributeKey#>)
            .execute()
        
    }
    
    func testUpdateItem() async throws {
        try await Keychain.genericPassword.makeUpdateQuery()
//            .setAttribute(<#T##attribute: KeychainItemAttributeValue##KeychainItemAttributeValue#>, forKey: <#T##KeychainItemAttributeKey#>)
            .execute()
    }
    
    func testGetItem() {
        
    }
    
    func testDeleteItem() {
        
    }
    
    func testAnySome() {
        let saveQuery = Keychain.genericPassword.makeSaveQuery()
        let searchQuery = Keychain.genericPassword.makeSearchQuery()
        
        let queries = [saveQuery, searchQuery].compactMap { $0 as? any Executable }
        
        func execute(query: some Executable) -> Void {
            Task {
                try? await query.execute()
            }
        }
        
        queries.forEach { query in
            execute(query: query)
        }
    }
}
