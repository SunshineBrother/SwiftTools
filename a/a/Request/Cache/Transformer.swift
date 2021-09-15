//
//  Transformer.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import Foundation

/// 缓存数据转换
public class Transformer<T> {
    let toData: (T?) -> Data?
    let fromData: (Data?) -> T?

    public init(toData: @escaping (T?) -> Data?, fromData: @escaping (Data?) -> T?) {
        self.toData = toData
        self.fromData = fromData
    }
}
