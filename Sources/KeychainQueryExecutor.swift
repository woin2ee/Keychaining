//
//  KeychainQueryExecutor.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/28.
//

import Foundation

protocol KeychainQueryExecutorType {
    
    static func save(query: KeychainItemDictionary) throws
    
    static func search(query: KeychainItemDictionary) throws -> AnyObject?
    
    static func update(query: KeychainItemDictionary, attributesToUpdate: KeychainItemDictionary) throws
    
    static func delete(query: KeychainItemDictionary) throws
    
}

struct KeychainQueryExecutor: KeychainQueryExecutorType {
    
    static func save(query: KeychainItemDictionary) throws {
        try delete(query: query)
        
        let status = SecItemAdd(query.asCFDictionary(), nil).asKeychainStatus
        if status != .success {
            throw status
        }
    }
    
    static func search(query: KeychainItemDictionary) throws -> AnyObject? {
        var result: AnyObject?
        let status = SecItemCopyMatching(query.asCFDictionary(), &result).asKeychainStatus
        guard status == .success else {
            throw status
        }
        return result
    }
    
    static func update(query: KeychainItemDictionary, attributesToUpdate: KeychainItemDictionary) throws {
        let status = SecItemUpdate(query.asCFDictionary(), attributesToUpdate.asCFDictionary()).asKeychainStatus
        if status != .success {
            throw status
        }
    }
    
    static func delete(query: KeychainItemDictionary) throws {
        let status = SecItemDelete(query.asCFDictionary()).asKeychainStatus
        if status != .success, status != .itemNotFound {
            throw status
        }
    }
    
}
