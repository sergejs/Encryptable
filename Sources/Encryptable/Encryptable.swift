//
//  Encryptable.swift
//  
//
//  Created by Sergejs Smirnovs on 09.11.21.
//

import Foundation

public protocol Encryptable {
  func encrypt(_ data: Data) throws -> Data
  func decrypt(_ data: Data) throws -> Data
}
