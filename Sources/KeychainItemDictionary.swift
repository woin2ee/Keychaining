//
//  KeychainItemDictionary.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/06/02.
//

import Foundation

protocol HasKeychainDictionary {
    
    var dictionary: KeychainItemDictionary { get }
    
}

protocol CFDictionaryConvertible: HasKeychainDictionary {
    
    /// Convert query to `CFDictionary`
    /// - Returns: <#description#>
    func asCFDictionary() -> CFDictionary
    
}

extension CFDictionaryConvertible {
    
    func asCFDictionary() -> CFDictionary {
        return dictionary.asCFDictionary()
    }
    
}
