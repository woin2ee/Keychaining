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
    
    func testSaveItem() {
        
        Keychain.genericPassword.makeSaveQuery()
//            .setAttribute(<#T##attribute: KeychainItemAttributeValue##KeychainItemAttributeValue#>, forKey: <#T##KeychainItemAttributeKey#>)
            .execute()
        
    }
    
    func testUpdateItem() {
        Keychain.genericPassword.makeUpdateQuery()
//            .setAttribute(<#T##attribute: KeychainItemAttributeValue##KeychainItemAttributeValue#>, forKey: <#T##KeychainItemAttributeKey#>)
            .execute()
    }
    
    func testGetItem() {
        
    }
    
    func testDeleteItem() {
        
    }
}
