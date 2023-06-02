//
//  KeychainingExampleTests.swift
//  Keychaining_Tests
//
//  Created by Jaewon Yun on 2023/06/02.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import Keychaining

/// For Usage in README.
final class KeychainingExampleTests: XCTestCase {
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
    }
    
    func test_basicUsage() {
    save:
        do {
            do {
                try Keychain.genericPassword.makeSaveQuery()
                    .setService("Keychaining")
                    .setAccount("Account")
                    .setDataFor("Private Data")
                    .execute()
            } catch {
                print(error)
                XCTFail("\(error)")
            }
        }
    search:
        do {
            do {
                let data = try Keychain.genericPassword.makeSearchQuery()
                    .setService("Keychaining")
                    .setAccount("Account")
                    .setReturnTypes(.data)
                    .execute()
                print(data)
                XCTAssertNotNil(data)
            } catch {
                print(error)
                XCTFail("\(error)")
            }
        }
    delete:
        do {
            do {
                try Keychain.genericPassword.makeDeleteQuery()
                    .setService("Keychaining")
                    .setAccount("Account")
                    .execute()
            } catch {
                print(error)
                XCTFail("\(error)")
            }
            do {
                let _ = try Keychain.genericPassword.makeSearchQuery()
                    .setService("Keychaining")
                    .setAccount("Account")
                    .setLabel("Label")
                    .setReturnTypes(.data)
                    .execute()
                XCTFail()
            } catch {
                print(error)
            }
        }
    deleteAll:
        do {
            do {
                try Keychain.genericPassword.makeDeleteQuery().execute()
            } catch {
                print(error)
                XCTFail("\(error)")
            }
            do {
                let _ = try Keychain.genericPassword.makeSearchQuery()
                    .setService("Keychaining")
                    .setAccount("Account")
                    .setLabel("Label")
                    .setReturnTypes(.data)
                    .execute()
                XCTFail()
            } catch {
                print(error)
            }
        }
    }
    
}
