//
//  Moya+Extensions.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import Foundation
import Moya


public protocol HMTargetType: ApiTargetType {
    var encoding: ParameterEncoding { get }
    /// 缓存策略
    var policy: CachePolicy { get }
    var parameters: [String: Any] { get }
 
}

extension HMTargetType {
    var cacheKey: String {
        let keyValue = parameters.map { "\($0.key):\($0.value)"}.sorted()
        let key: String = keyValue.joined(separator: "&")
        return path + "?" + key
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
}

enum HMMultiTarget: HMTargetType {

    var expiry: Expiry {
        return target.expiry
    }

    var encoding: ParameterEncoding {
        return target.encoding
    }

    var policy: CachePolicy {
        return target.policy
    }

    var parameters: [String: Any] {
        return target.parameters
    }

    /// The embedded `TargetType`.
    case target(HMTargetType)

    /// Initializes a `MultiTarget`.
    public init(_ target: HMTargetType) {
        self = HMMultiTarget.target(target)
    }

    /// The embedded target's base `URL`.
    public var path: String {
        return target.path
    }

    /// The baseURL of the embedded target.
    public var baseURL: URL {
        return target.baseURL
    }

    /// The HTTP method of the embedded target.
    public var method: Moya.Method {
        return target.method
    }

    /// The sampleData of the embedded target.
    public var sampleData: Data {
        return target.sampleData
    }

    /// The `Task` of the embedded target.
    public var task: Task {
        return target.task
    }

    /// The `ValidationType` of the embedded target.
    public var validationType: ValidationType {
        return target.validationType
    }

    /// The headers of the embedded target.
    public var headers: [String: String]? {
        return target.headers
    }

    /// The embedded `TargetType`.
    public var target: HMTargetType {
        switch self {
        case .target(let target): return target
        }
    }
}

public extension TargetType {

    var sampleData: Data {
        return Data()
    }
    
    ///  设置公共请求头
    var headers: [String: String]? {
        let headers: [String: String] = [String: String]()
       
        return headers
    }
}
