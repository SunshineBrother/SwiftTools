//
//  Data+Extensions.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation

// swiftlint:disable identifier_name
private let encrypt_vil: [UInt8] = [
    65, 68, 54, 52, 65, 53, 69, 48,
    52, 56, 57, 57, 69, 56, 56, 69,
    68, 48, 70, 55, 70, 50, 49, 51,
    65, 52, 68, 69, 54, 65, 53, 48
]

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }

    var encode: Data {
        var bytes: [UInt8] = []
        for (idx, str) in self.enumerated() {
            let temp = str ^ encrypt_vil[idx % encrypt_vil.count]
            bytes.append(temp)
        }
        let data = Data(bytes).base64EncodedData()
        return data
    }

    var decode: Data {
        guard let newData = Data(base64Encoded: self) else {
            return Data()
        }
        var bytes: [UInt8] = []
        for (idx, str) in newData.enumerated() {
            let temp = str ^ encrypt_vil[idx % encrypt_vil.count]
            bytes.append(temp)
        }
        return Data(bytes)
    }
}
