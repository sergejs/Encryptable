//
//  AES256CrypterError.swift
//  
//
//  Created by Sergejs Smirnovs on 09.11.21.
//

import CommonCrypto
import Foundation

public enum AES256CrypterError: Error, Equatable {
    case keyGeneration(status: Int)
    case malformattedSalt
    case wrongLengthOfSalt
    case wrongLengthOfPassword
    case cryptoFailed(status: CCCryptorStatus)
    case badKeyLength
    case badInputVectorLength
    case malformattedEncryptedData
}
