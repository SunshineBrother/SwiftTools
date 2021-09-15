//
//  HttpServer.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import UIKit
import Moya
import RxSwift

/// 判断response中服务器返回数据状态
///
/// 此方法根据服务器实际返回的数据做判断
 func responseIsSuccess(_ response: Response) -> Bool {
    guard let json = try? response.mapString() else {
        return false
    }
    guard let item = ResponseVerify(JSONString: json) else {
        return false
    }
    return item.code == NetworkConstant.successCode
}


var plugins: [PluginType] = [NewLoggerPlugin()]
let provider = MoyaProvider<ApiMultiTarget>(plugins: plugins)

public let server = HttpServer.share

/// 网络服务单例（添加加载动画使用）
public class HttpServer {
    static let share = HttpServer()
    init() {
    }
}

extension HttpServer {
    /// 开始加载动画
    ///
    /// - Parameter block: 传入执行开始动画的闭包
    /// - Returns: 返回 HttpServer 对象
    public func showLoading(_ block: (() -> Void)?) -> HttpServer {
        block?()
        return self
    }

    /// 请求网络
    ///
    /// 缓存策略已添加，数据转换需要外部处理
    public func request(api: ApiTargetType) -> Observable<Response> {
        let request = provider.rx.request(ApiMultiTarget(api)).asObservable()
        let strategy = api.policy.stratey(api: api, observable: request)
        return strategy.verifyMap(responseIsSuccess(_:)).run()
    }
}

