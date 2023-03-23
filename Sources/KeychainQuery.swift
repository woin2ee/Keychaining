//
//  KeychainQuery.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

public protocol KeychainQueryExecutable {
    
    associatedtype MaybeData
    
    @available(iOS 13.0, *)
    @discardableResult
    func execute() async throws -> MaybeData
}

//protocol QuerySettable {
//    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainQueryType
//    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainQueryType
//    func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainQueryType
//    func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainQueryType
//}

protocol SelfReturnable {
    associatedtype ReturnType: KeychainQueryType
}

protocol KeychainQueryAttributeSettable: SelfReturnable {
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> ReturnType
    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> ReturnType
}

protocol KeychainQueryReturnTypeSettable: SelfReturnable {
    
    func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> ReturnType
}

protocol KeychainQueryValueTypeSettable: SelfReturnable {
    
    func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> ReturnType
}


/// The Basic Keychain query type
protocol KeychainQueryType: SelfReturnable {
    
    var query: [KeychainItemKey: any KeychainItemValue] { get }
    
    init(classKey: KeychainItemClassKey, classValue: KeychainItemClassValue)
    
    init(_ query: [KeychainItemKey: any KeychainItemValue])
}

extension KeychainQueryType {
    
    func makeUpdatedSelf(key: KeychainItemKey, value: any KeychainItemValue) -> ReturnType {
        let updatedQuery = self.query.merging([key: value]) { $1 }
        return ReturnType.init(updatedQuery)
    }
    
    func asCFDictionary() -> CFDictionary {
        return query.reduce(into: [:]) { dict, element in
            dict[element.key.rawValue] = element.value.rawValue
        } as CFDictionary
    }
}

// MARK: - KeychainQuery

public struct KeychainQuery:
    KeychainQueryType,
    KeychainQueryAttributeSettable
{
    typealias ReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainQuery {
        return makeUpdatedSelf(key: key, value: attribute)
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
}

extension KeychainQuery {
    
    public var forSave: KeychainSaveQuery {
        return .init(self.query)
    }
    
    public var forSearch: KeychainSearchQuery {
        return .init(self.query)
    }
    
    public var forUpdate: KeychainUpdateQuery {
        return .init(self.query)
    }
    
    public var forDelete: KeychainDeleteQuery {
        return .init(self.query)
    }
}

// MARK: - KeychainSaveQuery

public struct KeychainSaveQuery:
    KeychainQueryType,
    KeychainQueryExecutable,
    KeychainQueryAttributeSettable,
    KeychainQueryValueTypeSettable
{
    typealias ReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuery {
        return makeUpdatedSelf(key: key, value: attribute)
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainSaveQuery {
        return makeUpdatedSelf(key: key, value: valueType)
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        // TODO: nil attr 검사
        let status = SecItemAdd(self.asCFDictionary(), nil)
        if status != errSecSuccess {
            throw KeychainError.unspecifiedError
        }
    }
}

// MARK: - KeychainSearchQuery

public struct KeychainSearchQuery:
    KeychainQueryType,
    KeychainQueryExecutable,
    KeychainQueryAttributeSettable,
    KeychainQueryReturnTypeSettable
{
    typealias ReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuery {
        return makeUpdatedSelf(key: key, value: attribute)
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainSearchQuery {
        return makeUpdatedSelf(key: key, value: returnType)
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws -> Data {
        // TODO: 구현
        var result: AnyObject?
        let status = SecItemCopyMatching(self.asCFDictionary(), &result)
        guard status == errSecSuccess else {
            throw KeychainError.unspecifiedError // TODO: 에러 정의
        }
        guard let resultData = result as? Data else {
            throw KeychainError.unspecifiedError // TODO: 에러 정의
        }
        return resultData
    }
}

// MARK: - KeychainUpdateQuery

public struct KeychainUpdateQuery: KeychainQueryType, KeychainQueryExecutable {
    
    typealias ReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
    }
    
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

public struct KeychainDeleteQuery:
    KeychainQueryType,
    KeychainQueryExecutable,
    KeychainQueryAttributeSettable
{
    typealias ReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuery {
        return makeUpdatedSelf(key: key, value: attribute)
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        // errcode -25300 : The specified item could not be found in the keychain.
        let status = SecItemDelete(self.asCFDictionary())
        if status != errSecSuccess, status != errSecItemNotFound {
            throw KeychainError.unspecifiedError
        }
    }
}
