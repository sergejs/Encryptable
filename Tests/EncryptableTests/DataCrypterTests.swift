//
//  DataCrypterTests.swift
//
//
//  Created by Sergejs Smirnovs on 09.11.21.
//

import CommonCrypto
@testable import Encryptable
import UIKit
import XCTest

final class DataCrypterTests: XCTestCase {
    let sut: Encryptable = DataCrypter()

    func testEmptyData() async throws {
        do {
            let digest = Data()
            let encrypted = try await digest.encrypt(with: sut)
            let decrypted = try await encrypted.decrypt(with: sut)
            XCTAssertEqual(decrypted, decrypted)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testString() async throws {
        do {
            let digest = "Test string".data(using: .utf8)!
            let encrypted = try await digest.encrypt(with: sut)
            let decrypted = try await encrypted.decrypt(with: sut)
            XCTAssertEqual(decrypted, decrypted)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testImage() async throws {
        do {
            let image = UIImage(systemName: "square.and.arrow.up")!
            let digest = image.pngData()!
            let encrypted = try await digest.encrypt(with: sut)
            let decrypted = try await encrypted.decrypt(with: sut)
            XCTAssertEqual(decrypted, decrypted)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}
