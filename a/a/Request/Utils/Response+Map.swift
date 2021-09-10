//
//  Response+Map.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation
import RxSwift
import Moya
import ObjectMapper


extension Response {
    /// 转换模型
    public func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        let json = try mapString()
        guard let object = Mapper<T>(context: context).map(JSONString: json) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

    
}

extension ObservableType where Element == Response {
    /// 新JSON转模型
    ///
    /// ResultModel 可根据需要替换
    public func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<ResultModel<T>> {
        return map { (response) in
            return try response.mapObject(ResultModel<T>.self, context: context)
        }
    }

    /// JSON转模型数组
    ///
    /// ListModel 可根据需要替换
    public func mapList<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<ListModel<T>> {
        return map { (response) in
            return try response.mapObject(ListModel<T>.self, context: context)
        }
    }

    /// JSON转String模型（var result: String）
    ///
    /// ResultModel 可根据需要替换
    public func mapStringModel() -> Observable<StringModel> {
        return map { (response) in
            return try response.mapObject(StringModel.self, context: nil)
        }
    }
    
    
    /// 一些特殊的model模型
    /// - Returns: model模型需要遵循 ObjectMappable 协议
    public func mapSpecialModel<T: ObjectMappable>() -> Observable<T> {
        return map { (response) in
            return try response.mapObject(T.self, context: nil)
        }
    }
    
    
    
}
