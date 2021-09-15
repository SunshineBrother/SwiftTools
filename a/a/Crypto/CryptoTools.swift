//
//  CryptoTools.swift
//  a
//
//  Created by HM on 2021/9/9.
//
/*
 https://www.hangge.com/blog/cache/detail_1865.html
 */

import CryptoSwift
import UIKit

enum HMSHAType {
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512
}

class CryptoTools: NSObject {
    /// md5加密
    /// - Parameter text: 加密文本
    /// - Returns: 加密结果
    static func MD5(text: String) -> String {
        return text.md5()
    }
    
    /// sha加密
    /// - Parameters:
    ///   - text: text description
    ///   - sha: sha description
    /// - Returns: description
    /*
     SHA 诞生于 1993 年，全称是安全散列算法(Secure Hash Algorithm)，由美国国家安全局（NSA）设计，之后被美国标准与技术研究院（NIST）收录到美国的联邦信息处理标准（FIPS）中，成为美国国家标准，SHA（后来被称作 SHA-0）于 1995 被 SHA-1（RFC3174）替代。
     SHA-1 的应用范围或许比 MD5 更加广泛，其安全性较 MD5 要高出很多。美国政府更是早在 1994 年就开始采用了 SHA-1 算法。
     SHA-1 生成长度为 160bit 的摘要信息串，虽然之后又出现了 SHA-224、SHA-256、SHA-384 和 SHA-512 等被统称为“SHA-2”的系列算法，但仍以 SHA-1 为主流。
     */
    static func SHA(text: String, sha: HMSHAType = .sha1) -> String {
        switch sha {
        case .sha1:
            return text.sha1()
        case .sha224:
            return text.sha224()
        case .sha256:
            return text.sha256()
        case .sha384:
            return text.sha384()
        case .sha512:
            return text.sha512()
        }
    }
    
    /// 密码加盐
    /// - Parameters:
    ///   - text: text
    ///   - salt: 加盐
    /// - Returns: description
    static func PBKDF2(text: String, salt: String) -> String {
        do {
            return try PKCS5.PBKDF2(password: text.bytes, salt: salt.bytes).calculate().toHexString()
        } catch {
            debugPrint("PBKDF2加密失败")
            return text
        }
    }
    
    
    
    /// AES加密
    /// - Parameters:
    ///   - text: 加密文本
    ///   - key: 密钥
    /// - Returns:
    static func AESEncrypt(text: String, key: String) -> String {
        do {
            let aes = try AES(key: Padding.zeroPadding.add(to: key.bytes,
                                                           blockSize: AES.blockSize),
                              blockMode: ECB())
            let encrypted = try aes.encrypt(text.bytes)
            return encrypted.toBase64()
        } catch {
            debugPrint("AESEncrypt加密失败")
            return text
        }
    }
    
    
    /// AES解密
    /// - Parameters:
    ///   - text: 加密密文
    ///   - key: 密钥
    /// - Returns:
    static func AESDecrypt(text: String, key: String) -> String {
        do {
            let aes = try AES(key: Padding.zeroPadding.add(to: key.bytes,
                                                           blockSize: AES.blockSize),
                              blockMode: ECB())
            let result = try text.decryptBase64ToString(cipher: aes)
            return result
        } catch {
            debugPrint("AESEncrypt解密失败")
            return text
        }
    }
    
    
    
    
}
