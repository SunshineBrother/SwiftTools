//
//  String+Security.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation
import CommonCrypto

// MARK: - Hmac加密枚举选项
enum CryptoAlgorithm {  // 2，SHA（安全散列算法：Secure Hash Algorithm） // 不可逆
    /// 加密的枚举选项 HMAC
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }

    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}
// MARK: - 加密算法
extension String {
    /**
     func: 加密方法
     - parameter algorithm: 加密方式；
     - parameter key: 加密的key
     */
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        //  CCHmac是系统内部方法
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
        let digest = stringFromResult(result: result, length: digestLen)
        result.deallocate()
        return digest
    }

    // 内部结果
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    /// MD5加密
    var MD5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)

        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }

        result.deallocate()

        return hash as String
    }

    var SHA: String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))

        let newData = NSData.init(data: data)
        CC_SHA1(newData.bytes, CC_LONG(data.count), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output as String
    }

    var SHA256: String {
        let data = self.data(using: String.Encoding.utf8)
        let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(((data! as NSData)).bytes, CC_LONG(data!.count), res?.mutableBytes.assumingMemoryBound(to: UInt8.self))
        let hashedString = "\(res!)".replacingOccurrences(of: "", with: "").replacingOccurrences(of: " ", with: "")
        let badchar: CharacterSet = CharacterSet(charactersIn: "\"<\",\">\"")
        let cleanedstring: String = (hashedString.components(separatedBy: badchar) as NSArray).componentsJoined(by: "")
        return cleanedstring
    }

    var SHA512: String {
        let data = self.data(using: String.Encoding.utf8)
        let res = NSMutableData(length: Int(CC_SHA512_DIGEST_LENGTH))
        CC_SHA512(((data! as NSData)).bytes, CC_LONG(data!.count), res?.mutableBytes.assumingMemoryBound(to: UInt8.self))
        let hashedString = "\(res!)".replacingOccurrences(of: "", with: "").replacingOccurrences(of: " ", with: "")
        let badchar: CharacterSet = CharacterSet(charactersIn: "\"<\",\">\"")
        let cleanedstring: String = (hashedString.components(separatedBy: badchar) as NSArray).componentsJoined(by: "")
        return cleanedstring
    }
}
