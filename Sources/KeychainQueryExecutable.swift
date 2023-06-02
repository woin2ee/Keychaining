//
//  KeychainQueryExecutable.swift
//  Keychaining
//
//  Created by Jaewon Yun on 2023/06/02.
//

import Foundation

public protocol KeychainQueryExecutable {
    
    associatedtype MaybeData
    
    @available(iOS 13.0, *)
    func execute() async throws -> MaybeData
    
    func execute() throws -> MaybeData
    
}

extension KeychainQueryExecutable {
    
    @available(iOS 13.0, *)
    public func execute() async throws -> MaybeData {
        return try await Task { try execute() }.value
    }
    
}
