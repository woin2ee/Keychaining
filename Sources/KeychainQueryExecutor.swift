//
//  KeychainQueryExecutor.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/28.
//

import Foundation

protocol KeychainQueryExecutorType {
    static func save(query: [KeychainItemKey: any KeychainItemValue]) throws
    static func search(query: [KeychainItemKey: any KeychainItemValue]) throws -> AnyObject?
    static func update(query: [KeychainItemKey: any KeychainItemValue], attributesToUpdate: [KeychainItemKey: any KeychainItemValue]) throws
    static func delete(query: [KeychainItemKey: any KeychainItemValue]) throws
}

// TODO: nil attr 검사
struct KeychainQueryExecutor: KeychainQueryExecutorType {
    
    static func save(query: [KeychainItemKey: any KeychainItemValue]) throws {
        let status = SecItemAdd(query.asCFDictionary(), nil)
        if status != errSecSuccess {
            throw KeychainStatus.init(status: status) ?? .unspecifiedError
        }
    }
    
    static func search(query: [KeychainItemKey: any KeychainItemValue]) throws -> AnyObject? {
        var result: AnyObject?
        let status = SecItemCopyMatching(query.asCFDictionary(), &result)
        guard status == errSecSuccess else {
            throw KeychainStatus.init(status: status) ?? .unspecifiedError
        }
        return result
    }
    
    static func update(query: [KeychainItemKey: any KeychainItemValue], attributesToUpdate: [KeychainItemKey: any KeychainItemValue]) throws {
        let status = SecItemUpdate(query.asCFDictionary(), attributesToUpdate.asCFDictionary())
        if status != errSecSuccess {
            throw KeychainStatus.init(status: status) ?? .unspecifiedError
        }
    }
    
    static func delete(query: [KeychainItemKey: any KeychainItemValue]) throws {
        let status = SecItemDelete(query.asCFDictionary())
        if status != errSecSuccess, status != errSecItemNotFound {
            throw KeychainStatus.init(status: status) ?? .unspecifiedError
        }
    }
}
