//
//  DataCrypterTests.swift
//  
//
//  Created by Sergejs Smirnovs on 09.11.21.
//


@testable import Encryptable
import XCTest
import CommonCrypto
import UIKit

final class DataCrypterTests: XCTestCase {
    let sut: Encryptable = DataCrypter()

    func testEmptyData() async throws {
        do {
            let digest = Data()
            let encrypted = try digest.encrypt(with: self.sut)
            let decrypted = try encrypted.decrypt(with: self.sut)
            XCTAssertEqual(decrypted, decrypted)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testString() async throws {
        do {
            let digest = "Test string".data(using: .utf8)!
            let encrypted = try digest.encrypt(with: self.sut)
            let decrypted = try encrypted.decrypt(with: self.sut)
            XCTAssertEqual(decrypted, decrypted)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testImage() async throws {
        do {
            let image = UIImage(systemName: "square.and.arrow.up")!
            let digest = image.pngData()!
            let encrypted = try digest.encrypt(with: self.sut)
            let decrypted = try encrypted.decrypt(with: self.sut)
            XCTAssertEqual(decrypted, decrypted)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}

/* 
import Foundation
class DataCrypterSpec: QuickSpec {
  let sut: Encryptable = DataCrypter()

  override func spec() {
    describe("DataCrypter") {


      context("String") {
        let digest = "Test string".data(using: .utf8)!
        var decrypted: Data?
        expect {
          let encrypted = try digest.encrypt(with: self.sut)
          decrypted = try encrypted.decrypt(with: self.sut)
        }.notTo(throwError())

        expect(decrypted).to(equal(digest))
      }

      context("Image") {
        let image = UIImage(systemName: "square.and.arrow.up")!
        let digest = image.pngData()!
        var decrypted: Data?
        expect {
          let encrypted = try digest.encrypt(with: self.sut)
          decrypted = try encrypted.decrypt(with: self.sut)
        }.notTo(throwError())

        expect(decrypted).to(equal(digest))
      }
    }
  }
}
*/
