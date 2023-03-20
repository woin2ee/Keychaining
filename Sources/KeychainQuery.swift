//
//  KeychainQuery.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

public class KeychainQuery {
    
    private var query: [KeychainItemKey: any KeychainItemValue]
    
    internal var cfDictionaryQuery: CFDictionary {
        query.reduce(into: [:]) { dict, element in
            dict[element.key.rawValue] = element.value.rawValue
        } as CFDictionary
    }
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainQuery {
        query.updateValue(attribute, forKey: key)
        return self
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func execute() {
        
    }
}

public class KeychainSaveQuery: KeychainQuery {
    
    @available(iOS 13.0, *)
    func save() async throws {
        let status = SecItemAdd(cfDictionaryQuery, nil)
        if status != errSecSuccess {
            throw KeychainError.unspecifiedError
        }
    }
}

public class KeychainSearchQuery: KeychainQuery {
    
//    @available(iOS 13.0, *)
//    var data: Data async {
//
//    }
    
    
    func save() async throws {
        let status = SecItemCopyMatching(cfDictionaryQuery, nil)
        if status != errSecSuccess {
            throw KeychainError.unspecifiedError
        }
    }
}

public class KeychainUpdateQuery: KeychainQuery {
    
//    let attributesToUpdate: [KeychainItemKey: any KeychainItemValue]
//
//    @available(iOS 13.0, *)
//    func save() async throws {
//
//        let status = SecItemUpdate(<#T##query: CFDictionary##CFDictionary#>, <#T##attributesToUpdate: CFDictionary##CFDictionary#>)
//
//        let status = SecItemAdd(cfDictionaryQuery, nil)
//        if status != errSecSuccess {
//            throw KeychainError.unspecifiedError
//        }
//    }
}

public class KeychainDeleteQuery: KeychainQuery {
    
//    @available(iOS 13.0, *)
//    func save() async throws {
//        
//        let status = SecItemDelete(<#T##query: CFDictionary##CFDictionary#>)
//        
//        let status = SecItemAdd(cfDictionaryQuery, nil)
//        if status != errSecSuccess {
//            throw KeychainError.unspecifiedError
//        }
//    }
}
