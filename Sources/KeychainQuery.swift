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

protocol KeychainItemAttributesSettable: SelfReturnable {
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

// MARK: - KeychainBasicQuerySetter

/// The Basic Keychain query setter type
///
/// Unexecutable.
protocol KeychainBasicQuerySetterType:
    HasKeychainDictionary,
    SelfReturnable,
    KeychainItemAttributesSettable
{
    init(classKey: KeychainItemClassKey, classValue: KeychainItemClassValue)
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue])
}

public struct KeychainBasicQuerySetter: KeychainBasicQuerySetterType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    init(copy: KeychainBasicQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainBasicQuerySetter {
        return KeychainBasicQuerySetter.init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainBasicQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
}

extension KeychainBasicQuerySetter {
    
    public var forSave: KeychainSaveQuerySetter {
        return .init(self.dictionary)
    }
    
    public var forSearch: KeychainSearchQuerySetter {
        return .init(self.dictionary)
    }
    
    public var forUpdate: KeychainUpdateQuerySetter {
        return .init(self.dictionary)
    }
    
    public var forDelete: KeychainDeleteQuerySetter {
        return .init(self.dictionary)
    }
}

// MARK: - KeychainSaveQuerySetter

protocol KeychainSaveQuerySetterType:
    KeychainBasicQuerySetterType,
    KeychainQueryExecutable,
    KeychainItemAttributesSettable,
    KeychainItemValueTypeSettable
{}

public struct KeychainSaveQuerySetter: KeychainSaveQuerySetterType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    init(copy: KeychainSaveQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuerySetter {
        return KeychainSaveQuerySetter.init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainSaveQuerySetter {
        return KeychainSaveQuerySetter.init(copy: self, updateSource: (key: key, value: valueType))
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        return try await Task { try execute() }.value
    }
    
    public func execute() throws {
        try KeychainQueryExecutor.save(query: dictionary)
    }
}

// MARK: - KeychainSearchQuerySetter

protocol KeychainSearchQuerySetterType:
    KeychainBasicQuerySetterType,
    KeychainQueryExecutable,
    KeychainItemAttributesSettable,
    KeychainItemReturnTypeSettable
{}

public struct KeychainSearchQuerySetter: KeychainSearchQuerySetterType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    init(copy: KeychainSearchQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuerySetter {
        return KeychainSearchQuerySetter.init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainSearchQuerySetter {
        return KeychainSearchQuerySetter.init(copy: self, updateSource: (key: key, value: returnType))
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws -> Data {
        return try await Task { try execute() }.value
    }
    
    public func execute() throws -> Data {
        guard let data = try KeychainQueryExecutor.search(query: dictionary) as? Data else {
            throw KeychainStatus.unspecifiedError
        }
        return data
    }
}

// MARK: - KeychainUpdateQuerySetter

protocol KeychainUpdateQuerySetterType:
    KeychainBasicQuerySetterType,
    KeychainQueryExecutable,
    KeychainItemAttributesSettable
{
    var attributesToUpdate: [KeychainItemKey: any KeychainItemValue] { get }
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, toUpdateForKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setAttribute(_ attribute: Any?, toUpdateForKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setValueType(_ valueType: KeychainItemValueTypeValue, toUpdateForKey key: KeychainItemValueTypeKey) -> SelfReturnType
}

public struct KeychainUpdateQuerySetter: KeychainUpdateQuerySetterType {
    
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
        copy: KeychainUpdateQuerySetter,
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
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainUpdateQuerySetter {
        return KeychainUpdateQuerySetter.init(copy: self, updateSource: (dictionary: (key: key, value: attribute), nil))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainUpdateQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, toUpdateForKey key: KeychainItemAttributeKey) -> KeychainUpdateQuerySetter {
        return KeychainUpdateQuerySetter.init(copy: self, updateSource: (nil, attributesToUpdate: (key: key, value: attribute)))
    }
    
    public func setAttribute(_ attribute: Any?, toUpdateForKey key: KeychainItemAttributeKey) -> KeychainUpdateQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), toUpdateForKey: key)
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, toUpdateForKey key: KeychainItemValueTypeKey) -> KeychainUpdateQuerySetter {
        return KeychainUpdateQuerySetter.init(copy: self, updateSource: (nil, attributesToUpdate: (key: key, value: valueType)))
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        return try await Task { try execute() }.value
    }
    
    public func execute() throws {
        try KeychainQueryExecutor.update(query: dictionary, attributesToUpdate: attributesToUpdate)
    }
}

// MARK: - KeychainDeleteQuerySetter

protocol KeychainDeleteQuerySetterType:
    KeychainBasicQuerySetterType,
    KeychainQueryExecutable,
    KeychainItemAttributesSettable
{}

public struct KeychainDeleteQuerySetter: KeychainDeleteQuerySetterType {
    
    typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    init(copy: KeychainDeleteQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuerySetter {
        return KeychainDeleteQuerySetter.init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    @available(iOS 13.0, *)
    public func execute() async throws {
        return try await Task { try execute() }.value
    }
    
    public func execute() throws {
        try KeychainQueryExecutor.delete(query: dictionary)
    }
}

// MARK: - KeychainDictionary

protocol KeychainDictionaryType:
    HasKeychainDictionary,
    KeychainItemClassSettable,
    KeychainItemAttributesSettable,
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
