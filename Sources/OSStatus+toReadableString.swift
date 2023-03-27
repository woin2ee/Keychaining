//
//  OSStatus+toReadableString.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/26.
//

import Foundation
import CoreFoundation

extension OSStatus {
    
    /// `OSStatus` 코드를 읽을 수 있는 문자열로 만들어 반환합니다.
    @available(iOS 11.3, *)
    public var toReadableString: String? {
        return SecCopyErrorMessageString(self, nil) as? String
    }
    
    public var asKeychainStatus: KeychainStatus {
        return .init(status: self) ?? .unspecifiedError
    }
}
