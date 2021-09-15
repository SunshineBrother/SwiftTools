//
//  ResultModel.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import Foundation
import ObjectMapper
/// 服务器返回json通用参数协议
public protocol ObjectMappable: Mappable {
    var code: String { get set }
    var message: String { get set }
}

/// 常规模型
public struct ResultModel<M: Mappable>: ObjectMappable {
    public var message: String = ""
    public var result: M?
    public var code: String = ""
    init() {}
    public init?(map: Map) {}

    mutating public func mapping(map: Map) {
        message   <- map["message"]
        result   <- map["data"]
        code   <- map["code"]
    }
}
/// 字符串模型
public struct StringModel: ObjectMappable {
    public var message: String = ""
    public var result: String = ""
    public var code: String = ""
   
    public init?(map: Map) {}

    mutating public func mapping(map: Map) {
        message      <- map["message"]
        result       <- map["data"]
        code         <- map["code"]
    }
}
/// 数组模型
public struct ListModel<M: Mappable>: ObjectMappable {
    public var message: String = ""
    public var result: [M] = []
    public var code: String = ""


    public init?(map: Map) {}

    mutating public func mapping(map: Map) {
        message   <- map["message"]
        result   <- map["data"]
        code   <- map["code"]
    }
}

// MARK: - Verify
/// 验证请求是否成功协议
public protocol VerifyMappable: Mappable {
    var message: String { get set }
    var code: String { get set }
}

/// 验证请求是否成功模型
public struct ResponseVerify: VerifyMappable {
    public var message: String = ""
    public var code: String = ""

    init() {}
    public init?(map: Map) {}

    mutating public func mapping(map: Map) {
        message   <- map["message"]
        code      <- map["code"]
    }
}
