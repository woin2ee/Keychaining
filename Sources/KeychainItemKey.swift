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
    public static let service: KeychainItemAttributeKey = .init(rawValue: kSecAttrService)
    public static let account: KeychainItemAttributeKey = .init(rawValue: kSecAttrAccount)
    // TODO: 나머지 추가
}

public class KeychainItemReturnTypeKey: KeychainItemKey {
    public static let returnData           : KeychainItemReturnTypeKey = .init(rawValue: kSecReturnData)
    public static let returnAttributes     : KeychainItemReturnTypeKey = .init(rawValue: kSecReturnAttributes)
    public static let returnRef            : KeychainItemReturnTypeKey = .init(rawValue: kSecReturnRef)
    public static let returnPersistentRef  : KeychainItemReturnTypeKey = .init(rawValue: kSecReturnPersistentRef)
}

public class KeychainItemValueTypeKey: KeychainItemKey {
    public static let valueData            : KeychainItemValueTypeKey = .init(rawValue: kSecValueData)
    public static let valueRef             : KeychainItemValueTypeKey = .init(rawValue: kSecValueRef)
    public static let valuePersistentRef   : KeychainItemValueTypeKey = .init(rawValue: kSecValuePersistentRef)
}

// classKey : 공통 필수 - O
// attributeKey : 공통 필수 - O
// returnTypeKey : 검색만 필수 - O
// ItemValueTypeKey : 저장, 업데이트 필수
