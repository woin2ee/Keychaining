//
//  Error+asKeychainError.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/26.
//

import Foundation

extension Error {
    
    public var asKeychainError: KeychainStatus? {
        self as? KeychainStatus
    }
}
