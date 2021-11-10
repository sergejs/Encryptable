//
//  AES256KeyFactoryTests.swift
//  
//
//  Created by Sergejs Smirnovs on 09.11.21.
//

@testable import Encryptable
import XCTest
import CommonCrypto

final class AES256KeyFactoryTests: XCTestCase {
    var sut: AES256KeyCreatable!

    func testFactorySetupSuccess() async throws {
        self.sut = AES256KeyFactory(saltProvider: { Data.randomGenerateBytes(count: 8) })
        do {
            let password = "password".data(using: .utf8)!
            let key = try self.sut.makeKey(with: password)
            XCTAssertEqual(key.count, kCCKeySizeAES256)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testFactorySetupThrows() async throws {
        self.sut = AES256KeyFactory(saltProvider: { nil })
        do {
            let password = "password".data(using: .utf8)!
            let key = try self.sut.makeKey(with: password)
            XCTAssertEqual(key.count, kCCKeySizeAES256)
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
        self.sut = AES256KeyFactory(saltProvider: { Data.randomGenerateBytes(count: 6) })
        do {
            let password = "password".data(using: .utf8)!
            let key = try self.sut.makeKey(with: password)
            XCTAssertEqual(key.count, kCCKeySizeAES256)
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
        self.sut = AES256KeyFactory(saltProvider: { Data.randomGenerateBytes(count: 16) })
        do {
            let password = "password".data(using: .utf8)!
            let key = try self.sut.makeKey(with: password)
            XCTAssertEqual(key.count, kCCKeySizeAES256)
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
        self.sut = AES256KeyFactory(saltProvider: { Data.randomGenerateBytes(count: 8) })
        do {
            let password = Data()
            let key = try self.sut.makeKey(with: password)
            XCTAssertEqual(key.count, kCCKeySizeAES256)
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
