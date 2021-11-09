//
//  AES256CrypterTests.swift
//
//
//  Created by Sergejs Smirnovs on 09.11.21.
//

import CommonCrypto
@testable import Encryptable
import XCTest

final class AES256CrypterTests: XCTestCase {
    var sut: Encryptable!

    let ivArrayCorrect: [UInt8] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let ivArrayShort: [UInt8] = [0, 0]
    let saltArray: [UInt8] = [0, 0, 0, 0, 0, 0, 0, 0]

    func testSuccess() async {
        let factory = AES256KeyFactory(saltProvider: { Data(self.saltArray) })
        let password = "password".data(using: .utf8)!
        do {
            let key = try factory.makeKey(with: password)
            sut = try AES256Crypter(key: key)
            XCTAssertEqual(key.count, kCCKeySizeAES256)

            let digest = "String".data(using: .utf8)!
            let encryptedData = try await digest.encrypt(with: sut)
            let decryptedData = try await encryptedData.decrypt(with: sut)
            XCTAssertEqual(decryptedData, digest)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testFailure() async {
        let factory = AES256KeyFactory(saltProvider: { Data(self.saltArray) })
        let password = "password".data(using: .utf8)!
        do {
            let key = try factory.makeKey(with: password)
            sut = try AES256Crypter(key: key)
            XCTAssertEqual(key.count, kCCKeySizeAES256)
            _ = try await Data().decrypt(with: sut)
            XCTFail("Should throw")
        } catch {
            guard
                let error = error as? AES256CrypterError
            else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssertEqual(AES256CrypterError.malformattedEncryptedData, error)
        }
    }

    func testEmptyKeyThrows() async {
        do {
            _ = try AES256Crypter(key: Data())
            XCTFail("Should throw")
        } catch {
            guard
                let error = error as? AES256CrypterError
            else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssertEqual(AES256CrypterError.badKeyLength, error)
        }
    }

    func testWrongKeyThrows() async {
        do {
            _ = try AES256Crypter(key: "Data".data(using: .utf8)!)
            XCTFail("Should throw")
        } catch {
            guard
                let error = error as? AES256CrypterError
            else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssertEqual(AES256CrypterError.badKeyLength, error)
        }
    }

    func testWrongVectorThrows() async {
        let factory = AES256KeyFactory(saltProvider: { Data(self.saltArray) })
        let password = "password".data(using: .utf8)!

        do {
            let key = try factory.makeKey(with: password)
            XCTAssertEqual(key.count, kCCKeySizeAES256)

            let sut = try AES256Crypter(
                key: key,
                ivProvider: { Data(self.ivArrayShort) }
            )
            _ = try await Data().encrypt(with: sut)
        } catch {
            guard
                let error = error as? AES256CrypterError
            else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssertEqual(AES256CrypterError.badInputVectorLength, error)
        }
    }

    func testNilVectorThrows() async {
        let factory = AES256KeyFactory(saltProvider: { Data(self.saltArray) })
        let password = "password".data(using: .utf8)!

        do {
            let key = try factory.makeKey(with: password)
            XCTAssertEqual(key.count, kCCKeySizeAES256)

            let sut = try AES256Crypter(
                key: key,
                ivProvider: { nil }
            )
            _ = try await Data().encrypt(with: sut)
        } catch {
            guard
                let error = error as? AES256CrypterError
            else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssertEqual(AES256CrypterError.badInputVectorLength, error)
        }
    }
}
