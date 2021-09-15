//
//  NetworkError.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import Foundation

public enum NetworkError: Error {
    case message(String)
    case failure
    case reqeatCount
    case noCache
    case empty
    case outTime

    case notCount

    case bindPhone
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .message(let msg):
            return msg
        case .failure:
            return "网络连接失败"
        case .reqeatCount:
            return "请求过于频繁，请稍后再试"
        case .noCache:
            return "未找到缓存,请连接网络后重试"
        case .empty:
            return "数据解析错误"
        case .outTime:
            return "请求超时"
        default:
            return ""
        }
    }
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        return description
    }
}
