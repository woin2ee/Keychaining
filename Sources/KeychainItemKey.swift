//
//  KeychainItemKey.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

// MARK: Templates
/*
 
/**
 aaaa
 
 A key wrapping the [`aaaa`](linklink) key.
 */
public static let aaaa: KeychainItemAttributeKey = .init(rawValue: ksecattr)
 
*/


// MARK: - Superclass of keys

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

// MARK: - Class key

/// A dictionary key whose value is the item's class.
final class KeychainItemClassKey: KeychainItemKey {
    static let `class`: KeychainItemClassKey = .init(rawValue: kSecClass)
}

// MARK: - Item Attribute Keys

/// Specify the attributes of keychain items.
///
/// For list groups, see [Item Attribute Keys and Values](https://developer.apple.com/documentation/security/keychain_services/keychain_items/item_attribute_keys_and_values)
public class KeychainItemAttributeKey: KeychainItemKey {
    
    // MARK: General Item Attribute Keys
    
    /*
     @available(macOS 10.7, *)
     public static let access: KeychainItemAttributeKey = .init(rawValue: kSecAttrAccess)
     */
    
    /**
     A key with a value that’s an access control instance indicating access control settings for the item.
     
     A key wrapping the [`kSecAttrAccessControl`](https://developer.apple.com/documentation/security/ksecattraccesscontrol) key.
     */
    public static let accessControl: KeychainItemAttributeKey = .init(rawValue: kSecAttrAccessControl)
    
    /**
     A key with a value that indicates when the keychain item is accessible.
     
     A key wrapping the [`kSecAttrAccessible`](https://developer.apple.com/documentation/security/ksecattraccessible) key.
     */
    public static let accessible: KeychainItemAttributeKey = .init(rawValue: kSecAttrAccessible)
    
    /**
     A key with a value that’s a string indicating the access group the item is in.
     
     A key wrapping the [`kSecAttrAccessGroup`](https://developer.apple.com/documentation/security/ksecattraccessgroup) key.
     */
    public static let accessGroup: KeychainItemAttributeKey = .init(rawValue: kSecAttrAccessGroup)
    
    /**
     A key with a value that’s a string indicating whether the item synchronizes through iCloud.
     
     A key wrapping the [`kSecAttrSynchronizable`](https://developer.apple.com/documentation/security/ksecattrsynchronizable) key.
     */
    public static let synchronizable: KeychainItemAttributeKey = .init(rawValue: kSecAttrSynchronizable)
    
    /**
     A key with a value that indicates the item's creation date.
     
     A key wrapping the [`kSecAttrCreationDate`](https://developer.apple.com/documentation/security/ksecattrcreationdate) key.
     */
    public static let creationDate: KeychainItemAttributeKey = .init(rawValue: kSecAttrCreationDate)
    
    /**
     A key with a value that indicates the item's most recent modification date.
     
     A key wrapping the [`kSecAttrModificationDate`](https://developer.apple.com/documentation/security/ksecattrmodificationdate) key.
     */
    public static let modificationDate: KeychainItemAttributeKey = .init(rawValue: kSecAttrModificationDate)
    
    /**
     A key with a value that’s a string indicating the item's description.
     
     A key wrapping the [`kSecAttrDescription`](https://developer.apple.com/documentation/security/ksecattrdescription) key.
     */
    public static let description: KeychainItemAttributeKey = .init(rawValue: kSecAttrDescription)
    
    /**
     A key with a value that’s a string indicating a comment associated with the item.
     
     A key wrapping the [`kSecAttrComment`](https://developer.apple.com/documentation/security/ksecattrcomment) key.
     */
    public static let comment: KeychainItemAttributeKey = .init(rawValue: kSecAttrComment)
    
    /**
     A key with a value that indicates the item's creator.
     
     A key wrapping the [`kSecAttrCreator`](https://developer.apple.com/documentation/security/ksecattrcreator) key.
     */
    public static let creator: KeychainItemAttributeKey = .init(rawValue: kSecAttrCreator)
    
    /**
     A key with a value that indicates the item's type.
     
     A key wrapping the [`kSecAttrType`](https://developer.apple.com/documentation/security/ksecattrtype) key.
     */
    public static let type: KeychainItemAttributeKey = .init(rawValue: kSecAttrType)
    
    /**
     A key with a value that’s a string indicating the item's label.
     
     A key wrapping the [`kSecAttrLabel`](https://developer.apple.com/documentation/security/ksecattrlabel) key.
     */
    public static let label: KeychainItemAttributeKey = .init(rawValue: kSecAttrLabel)
    
    /**
     A key with a value that’s a Boolean indicating the item's visibility.
     
     A key wrapping the [`kSecAttrIsInvisible`](https://developer.apple.com/documentation/security/ksecattrisinvisible) key.
     */
    public static let isInvisible: KeychainItemAttributeKey = .init(rawValue: kSecAttrIsInvisible)
    
    /**
     A key with a value that’s a Boolean indicating whether the item has a valid password.
     
     A key wrapping the [`kSecAttrIsNegative`](https://developer.apple.com/documentation/security/ksecattrisnegative) key.
     */
    public static let isNegative: KeychainItemAttributeKey = .init(rawValue: kSecAttrIsNegative)
    
    /**
     A key with a value that’s a string that provides a sync view hint.
     
     A key wrapping the [`kSecAttrSyncViewHint`](https://developer.apple.com/documentation/security/ksecattrsyncviewhint) key.
     */
    public static let syncViewHint: KeychainItemAttributeKey = .init(rawValue: kSecAttrSyncViewHint)
    
    /**
     none.
     
     A key wrapping the [`kSecAttrPersistantReference`](https://developer.apple.com/documentation/security/ksecattrpersistantreference) key.
     */
    public static let persistantReference: KeychainItemAttributeKey = .init(rawValue: kSecAttrPersistantReference)
    
    /**
     none.
     
     A key wrapping the [`kSecAttrPersistentReference`](https://developer.apple.com/documentation/security/ksecattrpersistentreference) key.
     */
    public static let persistentReference: KeychainItemAttributeKey = .init(rawValue: kSecAttrPersistentReference)
    
    // MARK: Password Attribute Keys
    
    /**
     A key whose value is a string indicating the item's account name.
     
     A key wrapping the [`kSecAttrAccount`](https://developer.apple.com/documentation/security/ksecattraccount) key.
     */
    public static let account: KeychainItemAttributeKey = .init(rawValue: kSecAttrAccount) // Both (GenericPassword, InternetPassword)
    
    /**
     A key whose value is a string indicating the item's service.
     
     A key wrapping the [`kSecAttrService`](https://developer.apple.com/documentation/security/ksecattrservice) key.
     */
    public static let service: KeychainItemAttributeKey = .init(rawValue: kSecAttrService) // Only GenericPassword
    
    /**
     A key whose value indicates the item's user-defined attributes.
     
     A key wrapping the [`kSecAttrGeneric`](https://developer.apple.com/documentation/security/ksecattrgeneric) key.
     */
    public static let generic: KeychainItemAttributeKey = .init(rawValue: kSecAttrGeneric) // Only GenericPassword
    
    /**
     A key whose value is a string indicating the item's security domain.
     
     A key wrapping the [`kSecAttrSecurityDomain`](https://developer.apple.com/documentation/security/ksecattrsecuritydomain) key.
     */
    public static let securityDomain: KeychainItemAttributeKey = .init(rawValue: kSecAttrSecurityDomain) // Only InternetPassword
    
    /**
     A key whose value is a string indicating the item's server.
     
     A key wrapping the [`kSecAttrServer`](https://developer.apple.com/documentation/security/ksecattrserver) key.
     */
    public static let server: KeychainItemAttributeKey = .init(rawValue: kSecAttrServer) // Only InternetPassword
    
    /**
     A key whose value indicates the item's protocol.
     
     A key wrapping the [`kSecAttrProtocol`](https://developer.apple.com/documentation/security/ksecattrprotocol) key.
     */
    public static let `protocol`: KeychainItemAttributeKey = .init(rawValue: kSecAttrProtocol) // Only InternetPassword (see Protocol Values)
    
    /**
     A key whose value indicates the item's authentication scheme.
     
     A key wrapping the [`kSecAttrAuthenticationType`](https://developer.apple.com/documentation/security/ksecattrauthenticationtype) key.
     */
    public static let authenticationType: KeychainItemAttributeKey = .init(rawValue: kSecAttrAuthenticationType) // see Authentication Type Values
    
    /**
     A key whose value indicates the item's port.
     
     A key wrapping the [`kSecAttrPort`](https://developer.apple.com/documentation/security/ksecattrport) key.
     */
    public static let port: KeychainItemAttributeKey = .init(rawValue: kSecAttrPort) // Only InternetPassword
    
    /**
     A key whose value is a string indicating the item's path attribute.
     
     A key wrapping the [`kSecAttrPath`](https://developer.apple.com/documentation/security/ksecattrpath) key.
     */
    public static let path: KeychainItemAttributeKey = .init(rawValue: kSecAttrPath) // Only InternetPassword
    
    // MARK: Certificate Attribute Keys
    
    /**
     A key whose value indicates the item's subject name.
     
     A key wrapping the [`kSecAttrSubject`](https://developer.apple.com/documentation/security/ksecattrsubject) key.
     */
    public static let subject: KeychainItemAttributeKey = .init(rawValue: kSecAttrSubject)
    
    /**
     A key whose value indicates the item's issuer.
     
     A key wrapping the [`kSecAttrIssuer`](https://developer.apple.com/documentation/security/ksecattrissuer) key.
     */
    public static let issuer: KeychainItemAttributeKey = .init(rawValue: kSecAttrIssuer)
    
    /**
     A key whose value indicates the item's serial number.
     
     A key wrapping the [`kSecAttrSerialNumber`](https://developer.apple.com/documentation/security/ksecattrserialnumber) key.
     */
    public static let serialNumber: KeychainItemAttributeKey = .init(rawValue: kSecAttrSerialNumber)
    
    /**
     A key whose value indicates the item's subject key ID.
     
     A key wrapping the [`kSecAttrSubjectKeyID`](https://developer.apple.com/documentation/security/ksecattrsubjectkeyid) key.
     */
    public static let subjectKeyID: KeychainItemAttributeKey = .init(rawValue: kSecAttrSubjectKeyID)
    
    /**
     A key whose value indicates the item's public key hash.
     
     A key wrapping the [`kSecAttrPublicKeyHash`](https://developer.apple.com/documentation/security/ksecattrpublickeyhash) key.
     */
    public static let publicKeyHash: KeychainItemAttributeKey = .init(rawValue: kSecAttrPublicKeyHash)
    
    /**
     A key whose value indicates the item's certificate type.
     
     A key wrapping the [`kSecAttrCertificateType`](https://developer.apple.com/documentation/security/ksecattrcertificatetype) key.
     */
    public static let certificateType: KeychainItemAttributeKey = .init(rawValue: kSecAttrCertificateType)
    
    /**
     A key whose value indicates the item's certificate encoding.
     
     A key wrapping the [`kSecAttrCertificateEncoding`](https://developer.apple.com/documentation/security/ksecattrcertificateencoding) key.
     */
    public static let certificateEncoding: KeychainItemAttributeKey = .init(rawValue: kSecAttrCertificateEncoding)
    
    // MARK: Cryptographic Key Attribute Keys
    
    /**
     A key whose value indicates the item's cryptographic key class.
     
     A key wrapping the [`kSecAttrKeyClass`](https://developer.apple.com/documentation/security/ksecattrkeyclass) key.
     */
    public static let keyClass: KeychainItemAttributeKey = .init(rawValue: kSecAttrKeyClass)
    
    /**
     A key whose value indicates the item's application label.
     
     A key wrapping the [`kSecAttrApplicationLabel`](https://developer.apple.com/documentation/security/ksecattrapplicationlabel) key.
     */
    public static let applicationLabel: KeychainItemAttributeKey = .init(rawValue: kSecAttrApplicationLabel)
    
    /**
     A key whose value indicates the item's private tag.
     
     A key wrapping the [`kSecAttrApplicationTag`](https://developer.apple.com/documentation/security/ksecattrapplicationtag) key.
     */
    public static let applicationTag: KeychainItemAttributeKey = .init(rawValue: kSecAttrApplicationTag)
    
    /**
     A key whose value indicates the item's algorithm.
     
     A key wrapping the [`kSecAttrKeyType`](https://developer.apple.com/documentation/security/ksecattrkeytype) key.
     */
    public static let keyType: KeychainItemAttributeKey = .init(rawValue: kSecAttrKeyType)
    
    /*
     @available(macOS 10.7, *)
     public static let PRF: KeychainItemAttributeKey = .init(rawValue: kSecAttrPRF)
     */
    
    /*
     @available(macOS 10.7, *)
     public static let salt: KeychainItemAttributeKey = .init(rawValue: kSecAttrSalt)
     */
    
    /*
     @available(macOS 10.7, *)
     public static let rounds: KeychainItemAttributeKey = .init(rawValue: kSecAttrRounds)
     */
    
    /**
     A key whose value indicates the number of bits in a cryptographic key.
     
     A key wrapping the [`kSecAttrKeySizeInBits`](https://developer.apple.com/documentation/security/ksecattrkeysizeinbits) key.
     */
    public static let keySizeInBits: KeychainItemAttributeKey = .init(rawValue: kSecAttrKeySizeInBits)
    
    /**
     A key whose value indicates the effective number of bits in a cryptographic key.
     
     A key wrapping the [`kSecAttrEffectiveKeySize`](https://developer.apple.com/documentation/security/ksecattreffectivekeysize) key.
     */
    public static let effectiveKeySize: KeychainItemAttributeKey = .init(rawValue: kSecAttrEffectiveKeySize)
    
    /**
     A key whose value indicates that a cryptographic key is in an external store.
     
     A key wrapping the [`kSecAttrTokenID`](https://developer.apple.com/documentation/security/ksecattrtokenid) key.
     */
    public static let tokenID: KeychainItemAttributeKey = .init(rawValue: kSecAttrTokenID)
    
    // MARK: Cryptographic Key Usage Attribute Keys
    
    /**
     A key whose value indicates the item's permanence.
     
     A key wrapping the [`kSecAttrIsPermanent`](https://developer.apple.com/documentation/security/ksecattrispermanent) key.
     */
    public static let isPermanent: KeychainItemAttributeKey = .init(rawValue: kSecAttrIsPermanent)
    
    /**
     A key whose value indicates the item's sensitivity.
     
     A key wrapping the [`kSecAttrIsSensitive`](https://developer.apple.com/documentation/security/ksecattrissensitive) key.
     */
    public static let isSensitive: KeychainItemAttributeKey = .init(rawValue: kSecAttrIsSensitive)
    
    /**
     A key whose value indicates the item's extractability.
     
     A key wrapping the [`kSecAttrIsExtractable`](https://developer.apple.com/documentation/security/ksecattrisextractable) key.
     */
    public static let isExtractable: KeychainItemAttributeKey = .init(rawValue: kSecAttrIsExtractable)
    
    /**
     A key whose value is a Boolean that indicates whether the cryptographic key can be used for encryption.
     
     A key wrapping the [`kSecAttrCanEncrypt`](https://developer.apple.com/documentation/security/ksecattrcanencrypt) key.
     */
    public static let canEncrypt: KeychainItemAttributeKey = .init(rawValue: kSecAttrCanEncrypt)
    
    /**
     A key whose value is a Boolean that indicates whether the cryptographic key can be used for decryption.
     
     A key wrapping the [`kSecAttrCanDecrypt`](https://developer.apple.com/documentation/security/ksecattrcandecrypt) key.
     */
    public static let canDecrypt: KeychainItemAttributeKey = .init(rawValue: kSecAttrCanDecrypt)
    
    /**
     A key whose value is a Boolean that indicates whether the cryptographic key can be used for derivation.
     
     A key wrapping the [`kSecAttrCanDerive`](https://developer.apple.com/documentation/security/ksecattrcanderive) key.
     */
    public static let canDerive: KeychainItemAttributeKey = .init(rawValue: kSecAttrCanDerive)
    
    /**
     A key whose value is a Boolean that indicates whether the cryptographic key can be used for digital signing.
     
     A key wrapping the [`kSecAttrCanSign`](https://developer.apple.com/documentation/security/ksecattrcansign) key.
     */
    public static let canSign: KeychainItemAttributeKey = .init(rawValue: kSecAttrCanSign)
    
    /**
     A key whose value is a Boolean that indicates whether the cryptographic key can be used for signature verification.
     
     A key wrapping the [`kSecAttrCanVerify`](https://developer.apple.com/documentation/security/ksecattrcanverify) key.
     */
    public static let canVerify: KeychainItemAttributeKey = .init(rawValue: kSecAttrCanVerify)
    
    /**
     A key whose value is a Boolean that indicates whether the cryptographic key can be used for wrapping.
     
     A key wrapping the [`kSecAttrCanWrap`](https://developer.apple.com/documentation/security/ksecattrcanwrap) key.
     */
    public static let canWrap: KeychainItemAttributeKey = .init(rawValue: kSecAttrCanWrap)
    
    /**
     A key whose value is a Boolean that indicates whether the cryptographic key can be used for unwrapping.
     
     A key wrapping the [`kSecAttrCanUnwrap`](https://developer.apple.com/documentation/security/ksecattrcanunwrap) key.
     */
    public static let canUnwrap: KeychainItemAttributeKey = .init(rawValue: kSecAttrCanUnwrap)
}

// MARK: - Item Result Keys

/**
 Use these keys to specify the type of results to return from a keychain item search or add operation.
 */
public class KeychainItemReturnTypeKey: KeychainItemKey {
    
    /**
     A key whose value is a Boolean indicating whether or not to return item data.
     
     A key wrapping the [`kSecReturnData`](https://developer.apple.com/documentation/security/ksecreturndata) key.
     */
    public static let returnData: KeychainItemReturnTypeKey = .init(rawValue: kSecReturnData)
    
    /**
     A key whose value is a Boolean indicating whether or not to return item attributes.
     
     A key wrapping the [`kSecReturnAttributes`](https://developer.apple.com/documentation/security/ksecreturnattributes) key.
     */
    public static let returnAttributes: KeychainItemReturnTypeKey = .init(rawValue: kSecReturnAttributes)
    
    /**
     A key whose value is a Boolean indicating whether or not to return a reference to an item.
     
     A key wrapping the [`kSecReturnRef`](https://developer.apple.com/documentation/security/ksecreturnref) key.
     */
    public static let returnRef: KeychainItemReturnTypeKey = .init(rawValue: kSecReturnRef)
    
    /**
     A key whose value is a Boolean indicating whether or not to return a persistent reference to an item.
     
     A key wrapping the [`kSecReturnPersistentRef`](https://developer.apple.com/documentation/security/ksecreturnpersistentref) key.
     */
    public static let returnPersistentRef: KeychainItemReturnTypeKey = .init(rawValue: kSecReturnPersistentRef)
}

// MARK: - Item Value Type Keys

/**
 These keys appear in the result dictionary when you specify more than one search result key.
 */
public class KeychainItemValueTypeKey: KeychainItemKey {
    
    /**
     A key whose value is the item's data.
     
     A key wrapping the [`kSecValueData`](https://developer.apple.com/documentation/security/ksecvaluedata) key.
     */
    public static let valueData: KeychainItemValueTypeKey = .init(rawValue: kSecValueData)
    
    /**
     A key whose value is a reference to the item.
     
     A key wrapping the [`kSecValueRef`](https://developer.apple.com/documentation/security/ksecvalueref) key.
     */
    public static let valueRef: KeychainItemValueTypeKey = .init(rawValue: kSecValueRef)
    
    /**
     A key whose value is a persistent reference to the item.
     
     A key wrapping the [`kSecValuePersistentRef`](https://developer.apple.com/documentation/security/ksecvaluepersistentref) key.
     */
    public static let valuePersistentRef: KeychainItemValueTypeKey = .init(rawValue: kSecValuePersistentRef)
}
