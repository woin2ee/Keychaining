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
    
    /// Boolean true value.
    public static let `true`: KeychainItemAttributeSynchronizabilityValue = .init(rawValue: kCFBooleanTrue!)
    
    /// Boolean false value.
    public static let `false`: KeychainItemAttributeSynchronizabilityValue = .init(rawValue: kCFBooleanFalse!)
    
    /// Specifies that both synchronizable and non-synchronizable results should be returned from a query.
    ///
    /// A attribute value wrapping the [`kSecAttrSynchronizableAny`](https://developer.apple.com/documentation/security/ksecattrsynchronizableany) value.
    public static let any: KeychainItemAttributeSynchronizabilityValue = .init(rawValue: kSecAttrSynchronizableAny)
}

public final class KeychainItemAttributeAccessibilityValue: KeychainItemAttributeValue {
    
    /// The data in the keychain can only be accessed when the device is unlocked. Only available if a passcode is set on the device.
    public static let whenPasscodeSetThisDeviceOnly: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
    
    /// The data in the keychain item can be accessed only while the device is unlocked by the user.
    public static let whenUnlockedThisDeviceOnly: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
    
    /// The data in the keychain item can be accessed only while the device is unlocked by the user.
    public static let whenUnlocked: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleWhenUnlocked)
    
    /// The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
    public static let afterFirstUnlockThisDeviceOnly: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
    
    /// The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
    public static let afterFirstUnlock: KeychainItemAttributeAccessibilityValue = .init(rawValue: kSecAttrAccessibleAfterFirstUnlock)
}

public final class KeychainItemAttributeProtocolValue: KeychainItemAttributeValue {
    
    /// FTP protocol.
    public static let ftp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolFTP)
    
    /// A client side FTP account.
    public static let ftpAccount: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolFTPAccount)
    
    /// HTTP protocol.
    public static let http: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolHTTP)
    
    /// IRC protocol.
    public static let irc: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIRC)
    
    /// NNTP protocol.
    public static let nntp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolNNTP)
    
    /// POP3 protocol.
    public static let pop3: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolPOP3)
    
    /// SMTP protocol.
    public static let smtp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolSMTP)
    
    /// SOCKS protocol.
    public static let socks: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolSOCKS)
    
    /// IMAP protocol.
    public static let imap: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIMAP)
    
    /// LDAP protocol.
    public static let ldap: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolLDAP)
    
    /// AFP over AppleTalk.
    public static let appleTalk: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolAppleTalk)
    
    /// AFP over TCP.
    public static let afp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolAFP)
    
    /// Telnet protocol.
    public static let telnet: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolTelnet)
    
    /// SSH protocol.
    public static let ssh: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolSSH)
    
    /// FTP over TLS/SSL.
    public static let ftps: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolFTPS)
    
    /// HTTP over TLS/SSL.
    public static let https: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolHTTPS)
    
    /// HTTP proxy.
    public static let httpProxy: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolHTTPProxy)
    
    /// HTTPS proxy.
    public static let httpsProxy: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolHTTPSProxy)
    
    /// FTP proxy.
    public static let ftpProxy: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolFTPProxy)
    
    /// SMB protocol.
    public static let smb: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolSMB)
    
    /// RTSP protocol.
    public static let rtsp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolRTSP)
    
    /// RTSP proxy.
    public static let rtspProxy: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolRTSPProxy)
    
    /// DAAP protocol.
    public static let daap: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolDAAP)
    
    /// Remote Apple Events.
    public static let eppc: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolEPPC)
    
    /// IPP protocol.
    public static let ipp: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIPP)
    
    /// NNTP over TLS/SSL.
    public static let nntps: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolNNTPS)
    
    /// LDAP over TLS/SSL.
    public static let ldaps: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolLDAPS)
    
    /// Telnet over TLS/SSL.
    public static let telnets: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolTelnetS)
    
    /// IMAP over TLS/SSL.
    public static let imaps: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIMAPS)
    
    /// IRC over TLS/SSL.
    public static let ircs: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolIRCS)
    
    /// POP3 over TLS/SSL.
    public static let pop3s: KeychainItemAttributeProtocolValue = .init(rawValue: kSecAttrProtocolPOP3S)
}

public final class KeychainItemAttributeAuthenticationTypeValue: KeychainItemAttributeValue {
    
    /// Windows NT LAN Manager authentication.
    public static let ntlm: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeNTLM)
    
    /// Microsoft Network default authentication.
    public static let msn: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeMSN)
    
    /// Distributed Password authentication.
    public static let dpa: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeDPA)
    
    /// Remote Password authentication.
    public static let rpa: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeRPA)
    
    /// HTTP Basic authentication.
    public static let httpBasic: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeHTTPBasic)
    
    /// HTTP Digest Access authentication.
    public static let httpDigest: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeHTTPDigest)
    
    /// HTML form based authentication.
    public static let htmlForm: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeHTMLForm)
    
    /// The default authentication type.
    public static let `default`: KeychainItemAttributeAuthenticationTypeValue = .init(rawValue: kSecAttrAuthenticationTypeDefault)
}

public final class KeychainItemAttributeKeyClassValue: KeychainItemAttributeValue {
    
    /// A public key of a public-private pair.
    public static let `public`: KeychainItemAttributeKeyClassValue = .init(rawValue: kSecAttrKeyClassPublic)
    
    /// A private key of a public-private pair.
    public static let `private`: KeychainItemAttributeKeyClassValue = .init(rawValue: kSecAttrKeyClassPrivate)
    
    /// A private key used for symmetric-key encryption and decryption.
    public static let symmetric: KeychainItemAttributeKeyClassValue = .init(rawValue: kSecAttrKeyClassSymmetric)
}

public final class KeychainItemAttributeKeyTypeValue: KeychainItemAttributeValue {
    
    /// RSA algorithm.
    public static let rsa: KeychainItemAttributeKeyTypeValue = .init(rawValue: kSecAttrKeyTypeRSA)
    
    /// Elliptic curve algorithm.
    public static let ecSecPrimeRandom: KeychainItemAttributeKeyTypeValue = .init(rawValue: kSecAttrKeyTypeECSECPrimeRandom)
}

public final class KeychainItemAttributeTokenIDValue: KeychainItemAttributeValue {
    
    /// Specifies an item should be stored in the device's Secure Enclave.
    public static let secureEnclave: KeychainItemAttributeTokenIDValue = .init(rawValue: kSecAttrTokenIDSecureEnclave)
}

public final class KeychainItemAttributeAccessGroupValue: KeychainItemAttributeValue, ExpressibleByStringInterpolation {
    
    public required init(rawValue: Any) {
        super.init(rawValue: rawValue)
    }
    
    public init(stringLiteral value: String) {
        super.init(rawValue: value)
    }
    
    /// The access group containing items provided by external tokens.
    public static let token: KeychainItemAttributeAccessGroupValue = .init(rawValue: kSecAttrAccessGroupToken)
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
        let data = string.data(using: encoding, allowLossyConversion: false)
        return .init(rawValue: data as Any)
    }
}
