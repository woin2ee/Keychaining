//
//  KeychainQuery.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

enum KeychainError: Error {
    case unspecifiedError
}

class KeychainQuery {
    
    private var query: [KeychainItemKey: any KeychainItemValue]
    
    internal var cfDictionaryQuery: CFDictionary {
        query.reduce(into: [:]) { dict, element in
            dict[element.key.rawValue] = element.value.rawValue
        } as CFDictionary
    }
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainQuery {
        query.updateValue(attribute, forKey: key)
        return self
    }
    
    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    
}

class KeychainSaveQuery: KeychainQuery {
    
    func save() async throws {
        let status = SecItemAdd(cfDictionaryQuery, nil)
        if status != errSecSuccess {
            throw KeychainError.unspecifiedError
        }
    }
}
