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
        Keychain.genericPassword.makeSaveQuery()
            .setService("Keychaining")
            .setAccount("Account")
            .setLabel("Label")
//            .setData()
    }
    
}
