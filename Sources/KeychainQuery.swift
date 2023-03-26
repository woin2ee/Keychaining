//
//  KeychainQuery.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

typealias KeychainItemPair = (key: KeychainItemKey, value: any KeychainItemValue)

public protocol KeychainQueryExecutable {
    associatedtype MaybeData
    
    @available(iOS 13.0, *)
    func execute() async throws -> MaybeData
    
    func execute() throws -> MaybeData
}

protocol SelfReturnable {
    associatedtype SelfReturnType: KeychainQueryType
    associatedtype UpdateSource
    
    init(copy: Self, updateSource source: UpdateSource)
}

protocol KeychainQueryAttributeSettable: SelfReturnable {
    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> SelfReturnType
}

protocol KeychainQueryReturnTypeSettable: SelfReturnable {
    func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> SelfReturnType
}

protocol KeychainQueryValueTypeSettable: SelfReturnable {
    func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> SelfReturnType
}

// MARK: - KeychainQuery

/// The Basic Keychain query type
protocol KeychainQueryType:
    SelfReturnable,
    KeychainQueryAttributeSettable
{
    var query: [KeychainItemKey: any KeychainItemValue] { get }
    
    init(classKey: KeychainItemClassKey, classValue: KeychainItemClassValue)
    
    init(_ query: [KeychainItemKey: any KeychainItemValue])
}

public struct KeychainQuery: KeychainQueryType {
    
    typealias SelfReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
    }
    
    init(copy: KeychainQuery, updateSource source: KeychainItemPair) {
        let updatedQuery = copy.query.merging([source.key: source.value]) { $1 }
        self.query = updatedQuery
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainQuery {
        return KeychainQuery.init(copy: self, updateSource: (key: key, value: attribute))
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

protocol KeychainSaveQueryType:
    KeychainQueryType,
    KeychainQueryExecutable,
    KeychainQueryAttributeSettable,
    KeychainQueryValueTypeSettable
{}

public struct KeychainSaveQuery: KeychainSaveQueryType {
    
    typealias SelfReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
    }
    
    init(copy: KeychainSaveQuery, updateSource source: KeychainItemPair) {
        let updatedQuery = copy.query.merging([source.key: source.value]) { $1 }
        self.query = updatedQuery
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuery {
        return KeychainSaveQuery.init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainSaveQuery {
        return KeychainSaveQuery.init(copy: self, updateSource: (key: key, value: valueType))
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        return try await Task { try execute() }.value
    }
    
    public func execute() throws {
        // TODO: nil attr 검사
        let status = SecItemAdd(query.asCFDictionary(), nil)
        if status != errSecSuccess {
            throw KeychainError.init(status: status) ?? .unspecifiedError
        }
    }
}

// MARK: - KeychainSearchQuery

protocol KeychainSearchQueryType:
    KeychainQueryType,
    KeychainQueryExecutable,
    KeychainQueryAttributeSettable,
    KeychainQueryReturnTypeSettable
{}

public struct KeychainSearchQuery: KeychainSearchQueryType {
    
    typealias SelfReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
    }
    
    init(copy: KeychainSearchQuery, updateSource source: KeychainItemPair) {
        let updatedQuery = copy.query.merging([source.key: source.value]) { $1 }
        self.query = updatedQuery
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuery {
        return KeychainSearchQuery.init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainSearchQuery {
        return KeychainSearchQuery.init(copy: self, updateSource: (key: key, value: returnType))
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws -> Data {
        return try await Task { try execute() }.value
    }
    
    public func execute() throws -> Data {
        var result: AnyObject?
        let status = SecItemCopyMatching(query.asCFDictionary(), &result)
        guard status == errSecSuccess, let resultData = result as? Data else {
            throw KeychainError.init(status: status) ?? .unspecifiedError
        }
        return resultData
    }
}

// MARK: - KeychainUpdateQuery

protocol KeychainUpdateQueryType:
    KeychainQueryType,
    KeychainQueryExecutable,
    KeychainQueryAttributeSettable
{
    var attributesToUpdate: [KeychainItemKey: any KeychainItemValue] { get }
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, toUpdateForKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setAttribute(_ attribute: Any?, toUpdateForKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setValueType(_ valueType: KeychainItemValueTypeValue, toUpdateForKey key: KeychainItemValueTypeKey) -> SelfReturnType
}

public struct KeychainUpdateQuery: KeychainUpdateQueryType {
    
    typealias SelfReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    let attributesToUpdate: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
        self.attributesToUpdate = [:]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
        self.attributesToUpdate = [:]
    }
    
    init(
        copy: KeychainUpdateQuery,
        updateSource source: (query: KeychainItemPair?, attributesToUpdate: KeychainItemPair?)
    ) {
        if let query = source.query {
            let updatedQuery = copy.query.merging([query.key: query.value]) { $1 }
            self.query = updatedQuery
        } else {
            self.query = copy.query
        }
        if let attributesToUpdate = source.attributesToUpdate {
            let updatedAttributesToUpdate = copy.attributesToUpdate.merging([attributesToUpdate.key: attributesToUpdate.value]) { $1 }
            self.attributesToUpdate = updatedAttributesToUpdate
        } else {
            self.attributesToUpdate = copy.attributesToUpdate
        }
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainUpdateQuery {
        return KeychainUpdateQuery.init(copy: self, updateSource: (query: (key: key, value: attribute), nil))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainUpdateQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, toUpdateForKey key: KeychainItemAttributeKey) -> KeychainUpdateQuery {
        return KeychainUpdateQuery.init(copy: self, updateSource: (nil, attributesToUpdate: (key: key, value: attribute)))
    }
    
    public func setAttribute(_ attribute: Any?, toUpdateForKey key: KeychainItemAttributeKey) -> KeychainUpdateQuery {
        return setAttribute(.init(rawValue: attribute as Any), toUpdateForKey: key)
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, toUpdateForKey key: KeychainItemValueTypeKey) -> KeychainUpdateQuery {
        return KeychainUpdateQuery.init(copy: self, updateSource: (nil, attributesToUpdate: (key: key, value: valueType)))
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        return try await Task { try execute() }.value
    }
    
    public func execute() throws {
        let status = SecItemUpdate(query.asCFDictionary(), attributesToUpdate.asCFDictionary())
        if status != errSecSuccess {
            throw KeychainError.init(status: status) ?? .unspecifiedError
        }
    }
}

// MARK: - KeychainDeleteQuery

protocol KeychainDeleteQueryType:
    KeychainQueryType,
    KeychainQueryExecutable,
    KeychainQueryAttributeSettable
{}

public struct KeychainDeleteQuery: KeychainDeleteQueryType {
    
    typealias SelfReturnType = Self
    
    let query: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.query = [classKey: classValue]
    }
    
    init(_ query: [KeychainItemKey: any KeychainItemValue]) {
        self.query = query
    }
    
    init(copy: KeychainDeleteQuery, updateSource source: KeychainItemPair) {
        let updatedQuery = copy.query.merging([source.key: source.value]) { $1 }
        self.query = updatedQuery
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuery {
        return KeychainDeleteQuery.init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        return try await Task { try execute() }.value
    }
    
    public func execute() throws {
        let status = SecItemDelete(query.asCFDictionary())
        if status != errSecSuccess, status != errSecItemNotFound {
            throw KeychainError.init(status: status) ?? .unspecifiedError
        }
    }
}
