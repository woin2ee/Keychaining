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
    
    public static let `true`: KeychainItemAttributeSynchronizabilityValue = .init(rawValue: kCFBooleanTrue!)
    public static let `false`: KeychainItemAttributeSynchronizabilityValue = .init(rawValue: kCFBooleanFalse!)
    public static let any: KeychainItemAttributeSynchronizabilityValue = .init(rawValue: kSecAttrSynchronizableAny)
}

public final class KeychainItemAttributeAccessibilityValue: KeychainItemAttributeValue {
    
    public static let whenPasscodeSetThisDeviceOnly: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
    public static let whenUnlockedThisDeviceOnly: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
    public static let whenUnlocked: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleWhenUnlocked)
    public static let afterFirstUnlockThisDeviceOnly: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
    public static let afterFirstUnlock: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleAfterFirstUnlock)
}

public final class KeychainItemAttributeProtocolValue: KeychainItemAttributeValue {
    
    public static let ftp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolFTP)
    public static let ftpAccount: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolFTPAccount)
    public static let http: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolHTTP)
    public static let irc: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIRC)
    public static let nntp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolNNTP)
    public static let pop3: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolPOP3)
    public static let smtp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolSMTP)
    public static let socks: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolSOCKS)
    public static let imap: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIMAP)
    public static let ldap: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolLDAP)
    public static let appleTalk: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolAppleTalk)
    public static let afp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolAFP)
    public static let telnet: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolTelnet)
    public static let ssh: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolSSH)
    public static let ftps: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolFTPS)
    public static let https: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolHTTPS)
    public static let httpProxy: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolHTTPProxy)
    public static let httpsProxy: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolHTTPSProxy)
    public static let ftpProxy: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolFTPProxy)
    public static let smb: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolSMB)
    public static let rtsp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolRTSP)
    public static let rtspProxy: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolRTSPProxy)
    public static let daap: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolDAAP)
    public static let eppc: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolEPPC)
    public static let ipp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIPP)
    public static let nntps: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolNNTPS)
    public static let ldaps: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolLDAPS)
    public static let telnets: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolTelnetS)
    public static let imaps: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIMAPS)
    public static let ircs: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIRCS)
    public static let pop3s: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolPOP3S)
}

public final class KeychainItemAttributeAuthenticationTypeValue: KeychainItemAttributeValue {
    
    public static let ntlm: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeNTLM)
    public static let msn: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeMSN)
    public static let dpa: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeDPA)
    public static let rpa: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeRPA)
    public static let httpBasic: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeHTTPBasic)
    public static let httpDigest: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeHTTPDigest)
    public static let htmlForm: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeHTMLForm)
    public static let `default`: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeDefault)
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
