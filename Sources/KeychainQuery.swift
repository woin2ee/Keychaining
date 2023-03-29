//
//  KeychainQuery.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

public typealias KeychainItemPair = (key: KeychainItemKey, value: any KeychainItemValue)

public protocol KeychainQueryExecutable {
    associatedtype MaybeData
    
    @available(iOS 13.0, *)
    func execute() async throws -> MaybeData
    
    func execute() throws -> MaybeData
}

public protocol SelfReturnable {
    associatedtype SelfReturnType
    associatedtype UpdateSource
    
    init(copy: Self, updateSource source: UpdateSource)
}

public protocol KeychainItemClassSettable: SelfReturnable {
    func setClass(_ class: KeychainItemClassValue) -> SelfReturnType
}

public protocol KeychainItemAttributesSettable: SelfReturnable {
    associatedtype KeychainClass: KeychainSpecificClassType
    
    func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> SelfReturnType
}

public protocol KeychainItemReturnTypeSettable: SelfReturnable {
    func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> SelfReturnType
}

public protocol KeychainItemValueTypeSettable: SelfReturnable {
    func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> SelfReturnType
}

protocol HasKeychainDictionary {
    var dictionary: [KeychainItemKey: any KeychainItemValue] { get }
}

// MARK: - KeychainBasicQuerySetter

protocol KeychainBasicQuerySetterType:
    HasKeychainDictionary,
    SelfReturnable,
    KeychainItemAttributesSettable
{
    init(classKey: KeychainItemClassKey, classValue: KeychainItemClassValue)
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue])
}

/// The Basic Keychain query setter type
///
/// Unexecutable.
public struct KeychainBasicQuerySetter<KeychainClass: KeychainSpecificClassType>: KeychainBasicQuerySetterType {
    
    public typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    public init(copy: KeychainBasicQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainBasicQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainBasicQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
}

extension KeychainBasicQuerySetter {
    
    public var forSave: KeychainSaveQuerySetter<KeychainClass> {
        return .init(self.dictionary)
    }
    
    public var forSearch: KeychainSearchQuerySetter<KeychainClass> {
        return .init(self.dictionary)
    }
    
    public var forUpdate: KeychainUpdateQuerySetter<KeychainClass> {
        return .init(self.dictionary)
    }
    
    public var forDelete: KeychainDeleteQuerySetter<KeychainClass> {
        return .init(self.dictionary)
    }
}

// MARK: - KeychainSaveQuerySetter

protocol KeychainSaveQuerySetterType:
    KeychainBasicQuerySetterType,
    KeychainItemValueTypeSettable,
    KeychainQueryExecutable
{}

public struct KeychainSaveQuerySetter<KeychainClass: KeychainSpecificClassType>: KeychainSaveQuerySetterType {
    
    public typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    public init(copy: KeychainSaveQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainSaveQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: valueType))
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
    KeychainItemReturnTypeSettable,
    KeychainQueryExecutable
{}

public struct KeychainSearchQuerySetter<KeychainClass: KeychainSpecificClassType>: KeychainSearchQuerySetterType {
    
    public typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    public init(copy: KeychainSearchQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainSearchQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: returnType))
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
    KeychainQueryExecutable
{
    var attributesToUpdate: [KeychainItemKey: any KeychainItemValue] { get }
    
    // TODO: KeychainClass 에 따라 업데이트 가능한 항목 제한
    func setAttribute(_ attribute: KeychainItemAttributeValue, toUpdateForKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setAttribute(_ attribute: Any?, toUpdateForKey key: KeychainItemAttributeKey) -> SelfReturnType
    func setValueType(_ valueType: KeychainItemValueTypeValue, toUpdateForKey key: KeychainItemValueTypeKey) -> SelfReturnType
}

public struct KeychainUpdateQuerySetter<KeychainClass: KeychainSpecificClassType>: KeychainUpdateQuerySetterType {
    
    public typealias SelfReturnType = Self
    
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
    
    public init(
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
        return .init(copy: self, updateSource: (dictionary: (key: key, value: attribute), nil))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainUpdateQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, toUpdateForKey key: KeychainItemAttributeKey) -> KeychainUpdateQuerySetter {
        return .init(copy: self, updateSource: (nil, attributesToUpdate: (key: key, value: attribute)))
    }
    
    public func setAttribute(_ attribute: Any?, toUpdateForKey key: KeychainItemAttributeKey) -> KeychainUpdateQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), toUpdateForKey: key)
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, toUpdateForKey key: KeychainItemValueTypeKey) -> KeychainUpdateQuerySetter {
        return .init(copy: self, updateSource: (nil, attributesToUpdate: (key: key, value: valueType)))
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
    KeychainQueryExecutable
{}

public struct KeychainDeleteQuerySetter<KeychainClass: KeychainSpecificClassType>: KeychainDeleteQuerySetterType {
    
    public typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
    }
    
    init(_ dictionary: [KeychainItemKey: any KeychainItemValue]) {
        self.dictionary = dictionary
    }
    
    public init(copy: KeychainDeleteQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: attribute))
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

// MARK: - KeychainDictionarySetter

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

public struct KeychainDictionarySetter: KeychainDictionaryType {
    
    public struct Unspecified: KeychainSpecificClassType {
        public var rawClassValue: KeychainItemClassValue
    }
    
    public typealias KeychainClass = Unspecified
    public typealias SelfReturnType = Self
    
    let dictionary: [KeychainItemKey: any KeychainItemValue]
    
    init() {
        self.dictionary = [:]
    }
    
    public init(copy: KeychainDictionarySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setClass(_ class: KeychainItemClassValue) -> KeychainDictionarySetter {
        return .init(copy: self, updateSource: (key: KeychainItemClassKey.class, value: `class`))
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainDictionarySetter {
        return .init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setAttribute(_ attribute: Any?, forKey key: KeychainItemAttributeKey) -> KeychainDictionarySetter {
        return setAttribute(.init(rawValue: attribute as Any), forKey: key)
    }
    
    public func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainDictionarySetter {
        return .init(copy: self, updateSource: (key: key, value: returnType))
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainDictionarySetter {
        return .init(copy: self, updateSource: (key: key, value: valueType))
    }
    
    public func asCFDictionary() -> CFDictionary {
        return dictionary.asCFDictionary()
    }
}

