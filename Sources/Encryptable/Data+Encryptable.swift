//
//  Data+Encryptable.swift
//
//
//  Created by Sergejs Smirnovs on 09.11.21.
//

import Foundation

public extension Data {
    func encrypt(with encrypter: Encryptable) async throws -> Data {
        try await encrypter.encrypt(self)
    }

    func decrypt(with encrypter: Encryptable) async throws -> Data {
        try await encrypter.decrypt(self)
    }
}
