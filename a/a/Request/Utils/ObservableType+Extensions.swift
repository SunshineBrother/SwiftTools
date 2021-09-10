//
//  ObservableType+Extensions.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation
import RxSwift
import Moya

extension Observable {
    /// 开始加载动画
    ///
    /// - Parameter block: 传入执行开始动画的闭包
    /// - Returns: 返回可观察对象类型
    public static func showLoading(_ block: (() -> Void)?) -> Observable.Type {
        block?()
        return Observable.self
    }
}

extension ObservableType {
    /// 停止加载动画
    ///
    /// - Parameter block: 传入执行停止动画的闭包
    /// - Returns: 返回可观察对象
    public func hidenLoading(_ block: (() -> Void)?) -> Observable<Element> {
        return self.do(onError: { (_) in
            block?()
        }, onCompleted: {
            block?()
        })
    }

    /// 出现错误时停止加载动画
    ///
    /// - Parameter block: 传入执行停止动画的闭包
    /// - Returns: 返回可观察对象
    public func hidenLoadingWithError(_ block: (() -> Void)?) -> Observable<Element> {
        return self.do(onError: { (_) in
            block?()
        })
    }
    
    
    
}

extension ObservableType where Element: ObjectMappable {
    /// 验证服务器返回数据是否成功
    public func verifyStatus() -> Observable<Element> {
        return flatMap({ (root) -> Observable<Element> in
            guard root.code == NetworkConstant.successCode else {
                if NetworkConstant.logoutCode.contains(root.code) {
                    // 登出 跳转登录界面
//                    LoginController.reLogin()
                }
                return Observable.error(NetworkError.message(root.message))
            }
            return Observable.just(root)
        })
    }
}

extension Observable where Element: Response {
    /// 缓存数据
    func saveCache(api: ApiTargetType, successResult: @escaping ((Response) -> Bool)) -> Observable<Element> {
        return map({ (root) in
            if successResult(root) {
                let json = root.data.stringValue
                Cache.share.setCache(json, key: api.cacheKey, expiry: api.expiry)
            }
            return root
        })
    }
}

