//
//  KeychainItemKey.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

// MARK: - Basic class of key

public class KeychainItemKey: RawRepresentable, Hashable {
    
    public let rawValue: CFString
    
    required public init(rawValue: CFString) {
        self.rawValue = rawValue
    }
    
    public static func == (left: KeychainItemKey, right: KeychainItemKey) -> Bool {
        return left.rawValue == right.rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

// MARK: - Subclass of key

class KeychainItemClassKey: KeychainItemKey {
    static let `class`: KeychainItemClassKey = .init(rawValue: kSecClass)
}

public class KeychainItemAttributeKey: KeychainItemKey {
    static let service: KeychainItemAttributeKey = .init(rawValue: kSecAttrService)
    static let account: KeychainItemAttributeKey = .init(rawValue: kSecAttrAccount)
    // TODO: 나머지 추가
}

class KeychainItemReturnTypeKey: KeychainItemKey {
    static let returnData           : KeychainItemReturnTypeKey = .init(rawValue: kSecReturnData)
    static let returnAttributes     : KeychainItemReturnTypeKey = .init(rawValue: kSecReturnAttributes)
    static let returnRef            : KeychainItemReturnTypeKey = .init(rawValue: kSecReturnRef)
    static let returnPersistentRef  : KeychainItemReturnTypeKey = .init(rawValue: kSecReturnPersistentRef)
}

class KeychainItemValueTypeKey: KeychainItemKey {
    static let valueData            : KeychainItemValueTypeKey = .init(rawValue: kSecValueData)
    static let valueRef             : KeychainItemValueTypeKey = .init(rawValue: kSecValueRef)
    static let valuePersistentRef   : KeychainItemValueTypeKey = .init(rawValue: kSecValuePersistentRef)
}
