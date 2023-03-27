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
    associatedtype SelfReturnType
    associatedtype UpdateSource
    
    init(copy: Self, updateSource source: UpdateSource)
}

protocol KeychainItemClassSettable: SelfReturnable {
    func setClass(_ class: KeychainItemClassValue) -> SelfReturnType
}

protocol KeychainItemAttributeSettable: SelfReturnable {
    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> SelfReturnType
}

protocol KeychainItemReturnTypeSettable: SelfReturnable {
    func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> SelfReturnType
}

protocol KeychainItemValueTypeSettable: SelfReturnable {
    func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> SelfReturnType
}

protocol HasKeychainDictionary {
    var dictionary: [KeychainItemKey: any KeychainItemValue] { get }
}

// MARK: - KeychainBasicQuery

/// The Basic Keychain query type
///
/// Unexecutable.
protocol KeychainBasicQueryType:
    HasKeychainDictionary,
    SelfReturnable,
    KeychainItemAttributeSettable
{
    init(classKey: KeychainItemClassKey, classValue: KeychainItemClassValue)
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue])
}

public struct KeychainBasicQuery: KeychainBasicQueryType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    init(copy: KeychainBasicQuery, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainBasicQuery {
        return KeychainBasicQuery.init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainBasicQuery {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
}

extension KeychainBasicQuery {
    
    public var forSave: KeychainSaveQuery {
        return .init(self.dictionary)
    }
    
    public var forSearch: KeychainSearchQuery {
        return .init(self.dictionary)
    }
    
    public var forUpdate: KeychainUpdateQuery {
        return .init(self.dictionary)
    }
    
    public var forDelete: KeychainDeleteQuery {
        return .init(self.dictionary)
    }
}

// MARK: - KeychainSaveQuery

protocol KeychainSaveQueryType:
    KeychainBasicQueryType,
    KeychainQueryExecutable,
    KeychainItemAttributeSettable,
    KeychainItemValueTypeSettable
{}

public struct KeychainSaveQuery: KeychainSaveQueryType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    init(copy: KeychainSaveQuery, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
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
        let status = SecItemAdd(dictionary.asCFDictionary(), nil)
        if status != errSecSuccess {
            throw KeychainStatus.init(status: status) ?? .unspecifiedError
        }
    }
}

// MARK: - KeychainSearchQuery

protocol KeychainSearchQueryType:
    KeychainBasicQueryType,
    KeychainQueryExecutable,
    KeychainItemAttributeSettable,
    KeychainItemReturnTypeSettable
{}

public struct KeychainSearchQuery: KeychainSearchQueryType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    init(copy: KeychainSearchQuery, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
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
        let status = SecItemCopyMatching(dictionary.asCFDictionary(), &result)
        guard status == errSecSuccess, let resultData = result as? Data else {
            throw KeychainStatus.init(status: status) ?? .unspecifiedError
        }
        return resultData
    }
}

// MARK: - KeychainUpdateQuery

protocol KeychainUpdateQueryType:
    KeychainBasicQueryType,
    KeychainQueryExecutable,
    KeychainItemAttributeSettable
{
    var attributesToUpdate: [KeychainItemKey: any KeychainItemValue] { get }
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, toUpdateForKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setAttribute(_ attribute: Any?, toUpdateForKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setValueType(_ valueType: KeychainItemValueTypeValue, toUpdateForKey key: KeychainItemValueTypeKey) -> SelfReturnType
}

public struct KeychainUpdateQuery: KeychainUpdateQueryType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    let attributesToUpdate: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
        self.attributesToUpdate = [:]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
        self.attributesToUpdate = [:]
    }
    
    init(
        copy: KeychainUpdateQuery,
        updateSource source: (dictionary: KeychainItemPair?, attributesToUpdate: KeychainItemPair?)
    ) {
        if let dictionary = source.dictionary {
            let updatedDictionary = copy.dictionary.merging([dictionary.key: dictionary.value]) { $1 }
            self.dictionary = updatedDictionary
        } else {
            self.dictionary = copy.dictionary
        }
        if let attributesToUpdate = source.attributesToUpdate {
            let updatedAttributesToUpdate = copy.attributesToUpdate.merging([attributesToUpdate.key: attributesToUpdate.value]) { $1 }
            self.attributesToUpdate = updatedAttributesToUpdate
        } else {
            self.attributesToUpdate = copy.attributesToUpdate
        }
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainUpdateQuery {
        return KeychainUpdateQuery.init(copy: self, updateSource: (dictionary: (key: key, value: attribute), nil))
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
        let status = SecItemUpdate(dictionary.asCFDictionary(), attributesToUpdate.asCFDictionary())
        if status != errSecSuccess {
            throw KeychainStatus.init(status: status) ?? .unspecifiedError
        }
    }
}

// MARK: - KeychainDeleteQuery

protocol KeychainDeleteQueryType:
    KeychainBasicQueryType,
    KeychainQueryExecutable,
    KeychainItemAttributeSettable
{}

public struct KeychainDeleteQuery: KeychainDeleteQueryType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    init(copy: KeychainDeleteQuery, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
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
        let status = SecItemDelete(dictionary.asCFDictionary())
        if status != errSecSuccess, status != errSecItemNotFound {
            throw KeychainStatus.init(status: status) ?? .unspecifiedError
        }
    }
}

// MARK: - KeychainDictionary

protocol KeychainDictionaryType:
    HasKeychainDictionary,
    KeychainItemClassSettable,
    KeychainItemAttributeSettable,
    KeychainItemReturnTypeSettable,
    KeychainItemValueTypeSettable
{
    init()
    
    func asCFDictionary() -> CFDictionary
}

public struct KeychainDictionary: KeychainDictionaryType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init() {
        self.dictionary = [:]
    }
    
    init(copy: KeychainDictionary, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setClass(_ class: KeychainItemClassValue) -> KeychainDictionary {
        return .init(copy: self, updateSource: (key: KeychainItemClassKey.class, value: `class`))
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainDictionary {
        return .init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainDictionary {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainDictionary {
        return .init(copy: self, updateSource: (key: key, value: returnType))
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainDictionary {
        return .init(copy: self, updateSource: (key: key, value: valueType))
    }
    
    public func asCFDictionary() -> CFDictionary {
        return dictionary.asCFDictionary()
    }
}
