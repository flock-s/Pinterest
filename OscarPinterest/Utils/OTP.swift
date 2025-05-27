//
//  OTP.swift
//  OscarPinterest
//
//  Created by Oscar Edward Guijaya on 27/5/25.
//

import Foundation
import CryptoKit

func generateTOTP(secret: Data, timeInterval: TimeInterval = 30, digits: Int = 6) -> String {
    let time = UInt64(Date().timeIntervalSince1970) / UInt64(timeInterval)
    var counter = time.bigEndian
    let counterData = Data(bytes: &counter, count: MemoryLayout<UInt64>.size)

    let hmac = HMAC<Insecure.SHA1>.authenticationCode(for: counterData, using: SymmetricKey(data: secret))
    let hmacData = Data(hmac)

    let offset = Int(hmacData.last! & 0x0f)
    let truncatedHash = hmacData.subdata(in: offset..<(offset + 4))

    var number = UInt32(bigEndian: truncatedHash.withUnsafeBytes { $0.load(as: UInt32.self) })
    number &= 0x7fffffff
    number = number % UInt32(pow(10, Float(digits)))

    return String(format: "%0*u", digits, number)
}

// let secret = "JBSWY3DPEHPK3PXP"
// let secretData = Data(base64Encoded: secret) ?? Data()
// let otp = generateTOTP(secret: secretData)

