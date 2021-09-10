//
//  BaseStrategy.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation
import RxSwift
import Moya

/// 缓存策略实现基类
class BaseStrategy {
    fileprivate var api: ApiTargetType
    fileprivate var observable: Observable<Response>

    fileprivate var successResult: ((Response) -> Bool)!

    init(api: ApiTargetType, observable: Observable<Response>) {
        self.api = api
        self.observable = observable
    }
    // 用于判断请求是否成功
    func verifyMap(_ tran: @escaping (Response) -> Bool) -> BaseStrategy {
        successResult = tran
        return self
    }

    func run() -> Observable<Response> {
        return Observable.empty()
    }
}

/// 不使用缓存的策略实现
class NoneStrategy: BaseStrategy {
    override func run() -> Observable<Response> {
        return observable
    }
}

/// 有缓存返回缓存，没有则请求网络
class CacheStrategy: BaseStrategy {
    override func run() -> Observable<Response> {
        let key = api.cacheKey
        if let model = Cache.share.cache(for: key)?.data(using: .utf8) {
            let response = Response(statusCode: 203, data: model)
            return Observable.just(response)
        } else {
            assert(successResult != nil, "verifyMap(:) 没有调用")
            return observable.saveCache(api: api, successResult: successResult)
        }
    }
}

/// 先返回缓存，在请求网络
class FirstCacheStrategy: BaseStrategy {

    override func run() -> Observable<Response> {
        assert(successResult != nil, "verifyMap(:) 没有调用")
        func loadCache(key: String) -> Observable<Response> {
            guard let model = Cache.share.cache(for: key)?.data(using: .utf8) else {
                return Observable.error(NetworkError.reqeatCount)
            }
            let response = Response(statusCode: 203, data: model)

            return Observable.just(response)
        }

        let key = api.cacheKey

        let request = observable.saveCache(api: api, successResult: successResult)

        guard let model = Cache.share.cache(for: key)?.data(using: .utf8) else {
            return request
        }
        let response = Response(statusCode: 203, data: model)

        return Observable.just(response).concat(request).distinctUntilChanged({ (item1, item2) -> Bool in
            return item1.data == item2.data
        })
    }
}

/// 先请求网络，失败在返回缓存
class FirstRequestStrategy: BaseStrategy {

    override func run() -> Observable<Response> {
        func loadCache(key: String, error: Error) -> Observable<Response> {
            guard let model = Cache.share.cache(for: key)?.data(using: .utf8) else {
                return Observable.error(error)
            }
            let response = Response(statusCode: 203, data: model)
            return Observable.just(response)
        }

        assert(successResult != nil, "verifyMap(:) 没有调用")

        let key = api.cacheKey

        let request = observable.saveCache(api: api, successResult: successResult)

        return request.catch({ (error) -> Observable<Response> in
            return loadCache(key: key, error: error)
        })
    }
}
