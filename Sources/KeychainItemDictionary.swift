//
//  KeychainItemDictionary.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/06/02.
//

import Foundation

public protocol HasKeychainDictionary {
    
    var dictionary: KeychainItemDictionary { get }
    
}

public protocol CFDictionaryConvertible: HasKeychainDictionary {
    
    /// Convert query to `CFDictionary`
    /// - Returns: <#description#>
    func asCFDictionary() -> CFDictionary
    
}

extension CFDictionaryConvertible {
    
    public func asCFDictionary() -> CFDictionary {
        return dictionary.asCFDictionary()
    }
    
}
