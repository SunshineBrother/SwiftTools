//
//  TransformerFactory.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation

/// 转换工厂类
public class TransformerFactory {
    public static func forString() -> Transformer<String> {
        let toData: (String?) -> Data? = { $0?.data(using: .utf8)?.encode }

        let fromData: (Data?) -> String? = { $0?.decode.toString() }

        return Transformer<String>(toData: toData, fromData: fromData)
    }
}
