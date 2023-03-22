//
//  KeychainQuery.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

public protocol Executable {
    
    associatedtype ReturnType
    
    @available(iOS 13.0, *)
    @discardableResult
    func execute() async throws -> ReturnType
}

protocol QuerySettable {
    
    associatedtype KeychainQueryType: KeychainQuery
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainQueryType
    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainQueryType
    func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainQueryType
    func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainQueryType
}

// MARK: - KeychainQuery (superclass)

public class KeychainQuery: QuerySettable {
    
    private var _query: [KeychainItemKey: any KeychainItemValue]
    
    func asCFDictionary() -> CFDictionary {
        return _query.reduce(into: [:]) { dict, element in
            dict[element.key.rawValue] = element.value.rawValue
        } as CFDictionary
    }
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self._query = [classKey: classValue]
    }
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainQuery {
        self.update(attribute, forKey: key)
        return self
    }

    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainQuery {
        self.update(returnType, forKey: key)
        return self
    }
    
    func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainQuery {
        self.update(valueType, forKey: key)
        return self
    }
    
    private func update(_ value: any KeychainItemValue, forKey key: KeychainItemKey) {
        _query.updateValue(value, forKey: key)
    }
}

// MARK: - KeychainSaveQuery

public class KeychainSaveQuery: KeychainQuery, Executable {
    
    public override func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuery {
        return super.setAttribute(attribute, forKey: key) as! KeychainSaveQuery
    }
    
    public override func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuery {
        return super.setAttribute(attribute, forKey: key) as! KeychainSaveQuery
    }
    
    public override func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainSaveQuery {
        return super.setValueType(valueType, forKey: key) as! KeychainSaveQuery
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        // TODO: 구현
        // TODO: nil attr 검사
        let status = SecItemAdd(self.asCFDictionary(), nil)
        if status != errSecSuccess {
            throw KeychainError.unspecifiedError
        }
    }
}

// MARK: - KeychainSearchQuery

public class KeychainSearchQuery: KeychainQuery, Executable {
    
    public override func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuery {
        return super.setAttribute(attribute, forKey: key) as! KeychainSearchQuery
    }
    
    public override func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuery {
        return super.setAttribute(attribute, forKey: key) as! KeychainSearchQuery
    }
    
    public override func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainSearchQuery {
        return super.setReturnType(returnType, forKey: key) as! KeychainSearchQuery
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws -> Data {
        // TODO: 구현
        let status = SecItemCopyMatching(self.asCFDictionary(), nil)
        if status != errSecSuccess {
            throw KeychainError.unspecifiedError
        }
        
        return .init()
    }
}

// MARK: - KeychainUpdateQuery

public class KeychainUpdateQuery: KeychainQuery, Executable {
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        
    }
    
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

// MARK: - KeychainDeleteQuery

public class KeychainDeleteQuery: KeychainQuery, Executable {
    
    public override func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuery {
        return super.setAttribute(attribute, forKey: key) as! KeychainDeleteQuery
    }
    
    public override func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuery {
        return super.setAttribute(attribute, forKey: key) as! KeychainDeleteQuery
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
//        let status = SecItemDelete(<#T##query: CFDictionary##CFDictionary#>)
    }
}
