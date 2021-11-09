//
//  AES256KeyFactoryTests.swift
//
//
//  Created by Sergejs Smirnovs on 09.11.21.
//

import CommonCrypto
@testable import Encryptable
import XCTest

final class AES256KeyFactoryTests: XCTestCase {
    var sut: AES256KeyCreatable!

    func testFactorySetupSuccess() async throws {
        sut = AES256KeyFactory(saltProvider: { Data.randomGenerateBytes(count: 8) })
        do {
            let password = "password".data(using: .utf8)!
            let key = try sut.makeKey(with: password)
            XCTAssertEqual(key.count, kCCKeySizeAES256)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testFactorySetupThrows() async throws {
        sut = AES256KeyFactory(saltProvider: { nil })
        do {
            let password = "password".data(using: .utf8)!
            _ = try sut.makeKey(with: password)
            XCTFail("Should throw")
        } catch {
            guard
                let error = error as? AES256CrypterError
            else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssertEqual(AES256CrypterError.malformattedSalt, error)
        }
    }

    func testFactorySetupShortSaltThrows() async throws {
        sut = AES256KeyFactory(saltProvider: { Data.randomGenerateBytes(count: 6) })
        do {
            let password = "password".data(using: .utf8)!
            _ = try sut.makeKey(with: password)
            XCTFail("Should throw")
        } catch {
            guard
                let error = error as? AES256CrypterError
            else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssertEqual(AES256CrypterError.wrongLengthOfSalt, error)
        }
    }

    func testFactorySetupLongSaltThrows() async throws {
        sut = AES256KeyFactory(saltProvider: { Data.randomGenerateBytes(count: 16) })
        do {
            let password = "password".data(using: .utf8)!
            _ = try sut.makeKey(with: password)
            XCTFail("Should throw")
        } catch {
            guard
                let error = error as? AES256CrypterError
            else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssertEqual(AES256CrypterError.wrongLengthOfSalt, error)
        }
    }

    func testFactorySetupEmtpyPasswordThrows() async throws {
        sut = AES256KeyFactory(saltProvider: { Data.randomGenerateBytes(count: 8) })
        do {
            let password = Data()
            _ = try sut.makeKey(with: password)
            XCTFail("Should throw")
        } catch {
            guard
                let error = error as? AES256CrypterError
            else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssertEqual(AES256CrypterError.wrongLengthOfPassword, error)
        }
    }
}
