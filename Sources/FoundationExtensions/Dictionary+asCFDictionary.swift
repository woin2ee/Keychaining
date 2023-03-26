//
//  Dictionary+asCFDictionary.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/23.
//

import Foundation

extension Dictionary<KeychainItemKey, KeychainItemValue> {
    
    func asCFDictionary() -> CFDictionary {
        return self.reduce(into: [:]) { dict, element in
            dict[element.key.rawValue] = element.value.rawValue
        } as CFDictionary
    }
}
