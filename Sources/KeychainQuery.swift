//
//  KeychainQuery.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

// MARK: - Protocols

public protocol UpdatedSelfCreatable {
    
    associatedtype UpdateSource
    
    init(copy: Self, updateSource source: UpdateSource)
    
}

public protocol KeychainItemClassSettable: UpdatedSelfCreatable {
    
    func setClass(_ class: KeychainItemClassValue) -> Self
    
}

public protocol KeychainItemReturnTypeSettable: UpdatedSelfCreatable {
    
    func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> Self
    
}

public protocol KeychainItemValueTypeSettable: UpdatedSelfCreatable {
    
    func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> Self
    
}

// MARK: - KeychainBasicQuerySetter

protocol KeychainBasicQuerySetterType:
    HasKeychainDictionary,
    CFDictionaryConvertible,
    UpdatedSelfCreatable,
    KeychainItemAttributesSettable
{
    
    init(classKey: KeychainItemClassKey, classValue: KeychainItemClassValue)
    
    init(_ dictionary: KeychainItemDictionary)
    
}

extension KeychainBasicQuerySetterType {
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self = .init([classKey: classValue])
    }
    
}

/// The Basic Keychain query setter.
///
/// Unexecutable.
public struct KeychainBasicQuerySetter<Attributes: KeychainCommonItemAttributes>: KeychainBasicQuerySetterType {
    
    public let dictionary: KeychainItemDictionary
    
    init(_ dictionary: KeychainItemDictionary) {
        self.dictionary = dictionary
    }
    
    public init(copy: KeychainBasicQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainBasicQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: attribute))
    }
    
}

extension KeychainBasicQuerySetter {
    
    public var forSave: KeychainSaveQuerySetter<Attributes> {
        return .init(self.dictionary)
    }
    
    public var forSearch: KeychainSearchQuerySetter<Attributes> {
        return .init(self.dictionary)
    }
    
    public var forUpdate: KeychainUpdateQuerySetter<Attributes> {
        return .init(self.dictionary)
    }
    
    public var forDelete: KeychainDeleteQuerySetter<Attributes> {
        return .init(self.dictionary)
    }
    
}

// MARK: - KeychainSaveQuerySetter

public struct KeychainSaveQuerySetter<Attributes: KeychainCommonItemAttributes>:
    KeychainBasicQuerySetterType,
    KeychainItemValueTypeSettable,
    KeychainQueryExecutable
{
    
    public let dictionary: KeychainItemDictionary
    
    init(_ dictionary: KeychainItemDictionary) {
        self.dictionary = dictionary
    }
    
    public init(copy: KeychainSaveQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSaveQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainSaveQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: valueType))
    }
    
    public func execute() throws {
        try KeychainQueryExecutor.save(query: dictionary)
    }
    
}

// MARK: - KeychainSearchQuerySetter

public struct KeychainSearchQuerySetter<Attributes: KeychainCommonItemAttributes>:
    KeychainBasicQuerySetterType,
    KeychainItemReturnTypeSettable,
    KeychainQueryExecutable
{
    
    public let dictionary: KeychainItemDictionary
    
    init(_ dictionary: KeychainItemDictionary) {
        self.dictionary = dictionary
    }
    
    public init(copy: KeychainSearchQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainSearchQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainSearchQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: returnType))
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
    
    var attributesToUpdate: KeychainItemDictionary { get }
    
    // TODO: KeychainClass 에 따라 업데이트 가능한 항목 제한
    func setAttribute(_ attribute: KeychainItemAttributeValue, toUpdateForKey key: KeychainItemAttributeKey) -> Self
    func setAttribute(_ attribute: Any?, toUpdateForKey key: KeychainItemAttributeKey) -> Self
    func setValueType(_ valueType: KeychainItemValueTypeValue, toUpdateForKey key: KeychainItemValueTypeKey) -> Self
    
}

public struct KeychainUpdateQuerySetter<Attributes: KeychainCommonItemAttributes>: KeychainUpdateQuerySetterType {
    
    public let dictionary: KeychainItemDictionary
    
    let attributesToUpdate: KeychainItemDictionary
    
    init(classKey: KeychainItemClassKey = .class, classValue: KeychainItemClassValue) {
        self.dictionary = [classKey: classValue]
        self.attributesToUpdate = [:]
    }
    
    init(_ dictionary: KeychainItemDictionary) {
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
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, toUpdateForKey key: KeychainItemAttributeKey) -> KeychainUpdateQuerySetter {
        return .init(copy: self, updateSource: (nil, attributesToUpdate: (key: key, value: attribute)))
    }
    
    public func setAttribute(_ attribute: Any?, toUpdateForKey key: KeychainItemAttributeKey) -> KeychainUpdateQuerySetter {
        return setAttribute(.init(rawValue: attribute as Any), toUpdateForKey: key)
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, toUpdateForKey key: KeychainItemValueTypeKey) -> KeychainUpdateQuerySetter {
        return .init(copy: self, updateSource: (nil, attributesToUpdate: (key: key, value: valueType)))
    }
    
    public func execute() throws {
        try KeychainQueryExecutor.update(query: dictionary, attributesToUpdate: attributesToUpdate)
    }
    
}

// MARK: - KeychainDeleteQuerySetter

public struct KeychainDeleteQuerySetter<Attributes: KeychainCommonItemAttributes>:
    KeychainBasicQuerySetterType,
    KeychainQueryExecutable
{
    
    public let dictionary: KeychainItemDictionary
    
    init(_ dictionary: KeychainItemDictionary) {
        self.dictionary = dictionary
    }
    
    public init(copy: KeychainDeleteQuerySetter, updateSource source: KeychainItemPair) {
        let updatedDictionary = copy.dictionary.merging([source.key: source.value]) { $1 }
        self.dictionary = updatedDictionary
    }
    
    public func setAttribute(_ attribute: KeychainItemAttributeValue, forKey key: KeychainItemAttributeKey) -> KeychainDeleteQuerySetter {
        return .init(copy: self, updateSource: (key: key, value: attribute))
    }
    
    public func execute() throws {
        try KeychainQueryExecutor.delete(query: dictionary)
    }
    
}

// MARK: - KeychainDictionarySetter

protocol KeychainDictionaryType:
    HasKeychainDictionary,
    CFDictionaryConvertible,
    KeychainItemClassSettable,
    KeychainItemAttributesSettable,
    KeychainItemReturnTypeSettable,
    KeychainItemValueTypeSettable
{
    
    init()
    
}

public struct KeychainDictionarySetter: KeychainDictionaryType {
    
    public final class Unspecified: KeychainCommonItemAttributes {}
    public typealias Attributes = Unspecified
    
    public let dictionary: KeychainItemDictionary
    
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
    
    public func setReturnType(_ returnType: KeychainItemReturnTypeValue, forKey key: KeychainItemReturnTypeKey) -> KeychainDictionarySetter {
        return .init(copy: self, updateSource: (key: key, value: returnType))
    }
    
    public func setValueType(_ valueType: KeychainItemValueTypeValue, forKey key: KeychainItemValueTypeKey) -> KeychainDictionarySetter {
        return .init(copy: self, updateSource: (key: key, value: valueType))
    }
    
}
