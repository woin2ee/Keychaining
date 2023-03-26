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
            XCTAssertEqual(error.asKeychainError?.errorCode, errSecNoSuchAttr)
            XCTAssertNotNil(error.asKeychainError?.errorMessage)
        }
    }
}
