//
//  KeychainingExceptionTests.swift
//  Keychaining_Tests
//
//  Created by Jaewon Yun on 2023/03/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import Keychaining

final class KeychainingExceptionTests: XCTestCase {
    
    func testExceptionIsKeychainErrorWhenExistNilAttribute() async {
        // Arrange
        let invalidQuery = Keychain.internetPassword.makeSaveQuery()
            .setAttribute(nil, forKey: .service)
        
        // Act
        do {
            try await invalidQuery.execute()
            XCTFail("Not occur exception.")
        }
        
        // Assert
        catch {
            if let errorMessage = error.asKeychainError?.errorMessage {
                print(errorMessage)
            }
            if error.asKeychainError == .noSuchAttr {
                XCTAssert(true)
            }
            XCTAssertEqual(error.asKeychainError?.errorCode, errSecNoSuchAttr)
            XCTAssertEqual(error.asKeychainError, .noSuchAttr)
            XCTAssertNotNil(error.asKeychainError?.errorMessage)
        }
    }
    
    func test_searchItemWhenNotExistItem() {
        // Act
        do {
            let data = try Keychain.genericPassword.makeSearchQuery()
                .setAccount("None")
                .execute()
            XCTFail()
        }
        
        // Assert
        catch {
            if error.asKeychainError == .itemNotFound {
                XCTAssert(true)
            }
        }
    }
    
}
