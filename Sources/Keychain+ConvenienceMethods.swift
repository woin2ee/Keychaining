//
//  Keychain+ConvenienceMethods.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/05/01.
//

import Foundation

extension Keychain {
    
    // MARK: - Set
    
    public static func set(_ string: String, forKey key: String) throws {
        var query = Keychain.genericPassword.makeSaveQuery()
            .setAccount(key)
            .setValueType(.data(for: string), forKey: .valueData)
        if let service = Bundle.main.bundleIdentifier {
            query = query.setService(service)
        }
        try query.execute()
    }
    
    @available(iOS 13.0, *)
    public static func set(_ string: String, forKey key: String) async throws {
        return try await Task { try Keychain.set(string, forKey: key) }.value
    }
    
    // MARK: - Get
    
    public static func getData(forKey key: String) throws -> Data {
        var query = Keychain.genericPassword.makeSearchQuery()
            .setAccount(key)
            .setReturnType(true, forKey: .returnData)
        if let service = Bundle.main.bundleIdentifier {
            query = query.setService(service)
        }
        return try query.execute()
    }
    
    @available(iOS 13.0, *)
    public static func getData(forKey key: String) async throws -> Data {
        return try await Task { try Keychain.getData(forKey: key) }.value
    }
    
    public static func getString(forKey key: String, encoding: String.Encoding = .utf8) throws -> String {
        let data = try getData(forKey: key)
        guard let string = String.init(data: data, encoding: encoding) else {
            throw KeychainingError.stringEncodingFailed
        }
        return string
    }
    
    @available(iOS 13.0, *)
    public static func getString(forKey key: String, encoding: String.Encoding = .utf8) async throws -> String {
        return try await Task { try Keychain.getString(forKey: key) }.value
    }
    
    // MARK: - Delete
    
    public static func delete(forKey key: String) throws {
        var query = Keychain.genericPassword.makeDeleteQuery()
            .setAccount(key)
        if let service = Bundle.main.bundleIdentifier {
            query = query.setService(service)
        }
        try query.execute()
    }
    
    @available(iOS 13.0, *)
    public static func delete(forKey key: String) async throws {
        return try await Task { try Keychain.delete(forKey: key) }.value
    }
    
}
