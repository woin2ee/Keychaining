//
//  Keychain.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

public struct Keychain {
    
    private let `class`: KeychainItemClassValue
    
    private init(class: KeychainItemClassValue) {
        self.class = `class`
    }
    
    public static let genericPassword   : Keychain = .init(class: .genericPassword)
    public static let internetPassword  : Keychain = .init(class: .internetPassword)
    public static let certificate       : Keychain = .init(class: .certificate)
    public static let key               : Keychain = .init(class: .key)
    public static let identity          : Keychain = .init(class: .identity)
    
    public func makeQuery() -> KeychainQuery {
        return .init(classValue: self.class)
    }
    
    public func makeSaveQuery() -> KeychainSaveQuery {
        return .init(classValue: self.class)
    }
    
    public func makeSearchQuery() -> KeychainSearchQuery {
        return .init(classValue: self.class)
    }
    
    public func makeUpdateQuery() -> KeychainUpdateQuery {
        return .init(classValue: self.class)
    }
    
    public func makeDeleteQuery() -> KeychainDeleteQuery {
        return .init(classValue: self.class)
    }
}
