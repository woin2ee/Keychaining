//
//  KeychainError.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

public enum KeychainError: Error {
    
    // 에러가 발생한 실제 OSStatus 값
    
    // 내가 정의한 에러
    
    // OSStatus 에 따른 에러
    
    case unspecifiedError(statusCode: OSStatus)
}

extension Error {
    
    public var asKeychainError: KeychainError? {
        self as? KeychainError
    }
}
