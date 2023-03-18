//
//  Keychain.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/03/18.
//

import Foundation

public struct Keychain {
    
    let `class`: KeychainItemClassValue
    
    public static let genericPassword: Keychain = .init(class: .genericPassword)
    public static let internetPassword: Keychain = .init(class: .internetPassword)
    
    public func makeQuery() -> KeychainQuery {
        return .init(classValue: self.class)
    }
    
    public func makeSaveQuery() -> KeychainSaveQuery {
        return .init(classValue: self.class)
    }
}

//meta 속성은 Keychain 아이템의 부가 정보를 저장하는 데 사용됩니다. 이 속성은 Keychain 아이템의 kSecAttrAccessible, kSecAttrAccessGroup, kSecAttrSynchronizable와 같은 정보를 포함합니다. 아래는 meta 속성으로 저장될 수 있는 정보의 예시입니다.
//
//kSecAttrAccessGroup: Keychain 아이템에 대한 접근 권한 그룹
//kSecAttrAccessible: Keychain 아이템에 대한 접근 권한
//kSecAttrSynchronizable: Keychain 아이템의 동기화 설정
//kSecAttrCreationDate: Keychain 아이템이 생성된 날짜
//kSecAttrModificationDate: Keychain 아이템이 마지막으로 수정된 날짜
//kSecAttrDescription: Keychain 아이템에 대한 설명
//kSecAttrComment: Keychain 아이템에 대한 주석
//kSecAttrCreator: Keychain 아이템을 생성한 애플리케이션의 개발자 코드
//kSecAttrType: Keychain 아이템의 유형
//meta 속성은 Keychain 아이템에 대한 부가적인 정보를 저장하기 위한 용도로 사용되며, Keychain 아이템 자체의 데이터는 meta 속성과 별도로 저장됩니다.
