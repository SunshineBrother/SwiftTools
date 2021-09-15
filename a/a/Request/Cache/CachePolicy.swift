//
//  CachePolicy.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation
import RxSwift
import Moya

/// 缓存策略
public enum CachePolicy {
    /// 不用缓存
    case none
    /// 用缓存，没有在请求网络
    case cache
    /// 先用缓存，在请求网络，得到网络数据后覆盖缓存
    case firstCache
    /// 先请求网络，失败后再返回缓存
    case firstRequest
}

extension CachePolicy {
    func stratey(api: ApiTargetType, observable: Observable<Response>) -> BaseStrategy {
        switch self {
        case .none:
            return NoneStrategy(api: api, observable: observable)
        case .cache:
            return CacheStrategy(api: api, observable: observable)
        case .firstCache:
            return FirstCacheStrategy(api: api, observable: observable)
        case .firstRequest:
            return FirstRequestStrategy(api: api, observable: observable)
        }
    }
}
