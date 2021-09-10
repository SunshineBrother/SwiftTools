//
//  MultiTarget.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Moya

public protocol ApiTargetType: TargetType {
    var encoding: ParameterEncoding { get }
    var parameters: [String: Any] { get }
    var policy: CachePolicy { get }
    var cacheKey: String { get }
    var expiry: Expiry { get }
}

public extension ApiTargetType {
    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var cacheKey: String {
        let keyValue = parameters.map { "\($0.key)=\($0.value)"}.sorted()
        let key: String = keyValue.joined(separator: "&")
                    debugPrint("缓存key: ", key)
        return key
    }

    var expiry: Expiry {
        return .time(.minute(30))
    }
}

/// TargetType 包装，可以使用多个api
enum ApiMultiTarget: ApiTargetType {
    /// The embedded `TargetType`.
    case target(ApiTargetType)

    /// Initializes a `MultiTarget`.
    public init(_ target: ApiTargetType) {
        self = ApiMultiTarget.target(target)
    }

    var expiry: Expiry {
        return target.expiry
    }

    var encoding: ParameterEncoding {
        return target.encoding
    }

    var parameters: [String: Any] {
        return target.parameters
    }

    var policy: CachePolicy {
        return target.policy
    }

    var cacheKey: String {
        return target.cacheKey
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
    public var target: ApiTargetType {
        switch self {
        case .target(let target): return target
        }
    }
}
