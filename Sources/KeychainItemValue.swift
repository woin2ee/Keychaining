//
//  KeychainItemValue.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

public protocol KeychainItemValue: RawRepresentable {}

// MARK: - KeychainItemClassValue

public struct KeychainItemClassValue: KeychainItemValue {
    
    public let rawValue: CFString
    
    public init(rawValue: CFString) {
        self.rawValue = rawValue
    }
    
    /**
     The value that indicates a generic password item.
     
     A value wrapping the [`kSecClassGenericPassword`](https://developer.apple.com/documentation/security/ksecclassgenericpassword) value.
     */
    public static let genericPassword: KeychainItemClassValue = .init(rawValue: kSecClassGenericPassword)
    
    /**
     The value that indicates an Internet password item.
     
     A value wrapping the [`kSecClassInternetPassword`](https://developer.apple.com/documentation/security/ksecclassinternetpassword) value.
     */
    public static let internetPassword: KeychainItemClassValue = .init(rawValue: kSecClassInternetPassword)
    
    /**
     The value that indicates a certificate item.
     
     A value wrapping the [`kSecClassCertificate`](https://developer.apple.com/documentation/security/ksecclasscertificate) value.
     */
    public static let certificate: KeychainItemClassValue = .init(rawValue: kSecClassCertificate)
    
    /**
     The value that indicates a cryptographic key item.
     
     A value wrapping the [`kSecClassKey`](https://developer.apple.com/documentation/security/ksecclasskey) value.
     */
    public static let key: KeychainItemClassValue = .init(rawValue: kSecClassKey)
    
    /**
     The value that indicates an identity item.
     
     A value wrapping the [`kSecClassIdentity`](https://developer.apple.com/documentation/security/ksecclassidentity) value.
     */
    public static let identity: KeychainItemClassValue = .init(rawValue: kSecClassIdentity)
}

// MARK: - KeychainItemAttributeValue

public class KeychainItemAttributeValue: KeychainItemValue {
    
    public let rawValue: Any
    
    public required init(rawValue: Any) {
        self.rawValue = rawValue
    }
}

public final class KeychainItemAttributeSynchronizabilityValue: KeychainItemAttributeValue, ExpressibleByBooleanLiteral {
    
    public required init(rawValue: Any) {
        super.init(rawValue: rawValue)
    }
    
    public init(booleanLiteral value: Bool) {
        super.init(rawValue: value)
    }
    
    public static let `true`: KeychainItemAttributeSynchronizabilityValue = .init(rawValue: kCFBooleanTrue)
    public static let `false`: KeychainItemAttributeSynchronizabilityValue = .init(rawValue: kCFBooleanFalse)
    public static let any: KeychainItemAttributeSynchronizabilityValue = .init(rawValue: kSecAttrSynchronizableAny)
}

public final class KeychainItemAttributeAccessibilityValue: KeychainItemAttributeValue {
    
    public required init(rawValue: Any) {
        super.init(rawValue: rawValue)
    }
    
    public static let whenPasscodeSetThisDeviceOnly: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
    public static let whenUnlockedThisDeviceOnly: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
    public static let whenUnlocked: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleWhenUnlocked)
    public static let afterFirstUnlockThisDeviceOnly: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
    public static let afterFirstUnlock: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleAfterFirstUnlock)
}

// MARK: - KeychainItemReturnTypeValue

public struct KeychainItemReturnTypeValue: KeychainItemValue, ExpressibleByBooleanLiteral {
    
    public let rawValue: CFBoolean
    
    public init(rawValue: CFBoolean) {
        self.rawValue = rawValue
    }
    
    public init(booleanLiteral rawValue: Bool) {
        self.rawValue = rawValue as CFBoolean
    }
    
    public static let `true`: KeychainItemReturnTypeValue = .init(rawValue: kCFBooleanTrue)
    public static let `false`: KeychainItemReturnTypeValue = .init(rawValue: kCFBooleanFalse)
}

// MARK: - KeychainItemValueTypeValue

public struct KeychainItemValueTypeValue: KeychainItemValue {
    
    public let rawValue: Any
    
    public init(rawValue: Any) {
        self.rawValue = rawValue
    }
    
    public static func data(_ data: Data) -> KeychainItemValueTypeValue {
        return .init(rawValue: data)
    }
    
    public static func data(for string: String, using encoding: String.Encoding = .utf8) -> KeychainItemValueTypeValue {
        let data = string.data(using: encoding)
        return .init(rawValue: data as Any)
    }
}
