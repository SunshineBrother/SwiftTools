//
//  ZECache.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Foundation

import Moya

enum StatusCode: Int {
    case cache = 1001
}

// extension TransformerFactory {
//    static func forResponse<T: Moya.Response>(_ type: T.Type) -> Transformer<T> {
//        let toData: (T) throws -> Data = { $0.data }
//        let fromData: (Data) throws -> T = {
//            T(statusCode: StatusCode.cache.rawValue, data: $0)
//        }
//
//        return Transformer<T>(toData: toData, fromData: fromData)
//    }
//
//    static func forString() -> Transformer<String> {
//        let toData: (String) throws -> Data = { $0.data(using: .utf8) ?? Data() }
//        let fromData: (Data) throws -> String = { String(data: $0, encoding: .utf8) ?? "" }
//        return Transformer(toData: toData, fromData: fromData)
//    }
// }
//
struct CacheName {
    static let MoyaResponse = "CacheMoyaResponse"
    static let Json = "Cache.Json"
}

public struct ZECache {
    public static let shard = ZECache()

    let jsonweStorage = DiskStorage<String>(config: DiskConfig(name: CacheName.MoyaResponse, maxSize: 10000, expiry: .never), transformer: TransformerFactory.forString())
//        try? Storage<Data>(
//        diskConfig: DiskConfig(name: CacheName.MoyaResponse, expiry: Expiry.seconds(7 * 24 * 3600), maxSize: 10000, protectionType: .complete),
//        memoryConfig: MemoryConfig(),
//        transformer: TransformerFactory.forData()
//    )

    @discardableResult
    func cacheResponse(_ response: Response, key: String) -> Bool {
        guard let obj = try? response.mapString() else {
            return false
        }
        return ZECache.shard.jsonweStorage.setObject(obj, forKey: key)
//        do {
//            try
//            return true
//        } catch {
//            return false
//        }
    }

    func fetchResponseCache(key: String) -> Response? {
        guard let json = ZECache.shard.jsonweStorage.object(forKey: key)?.data(using: .utf8) else {
            return nil
        }
//        guard let response = ((try? ZECache.shard.jsonweStorage?.object(forKey: key)) as Data??) else {
//            return nil
//        }
//        guard let data = response else {
//            return nil
//        }
        let cacheResp = Response(statusCode: 200, data: json)
        return cacheResp
    }

    public func removeAll() {
        jsonweStorage.removeAll()
//        do {
//            try jsonweStorage?.removeAll()
//        } catch {
//           print(error.localizedDescription)
//        }
    }
}

extension Response {
    func isEquel(_ response: Response, at key: String) throws -> Bool {
        let json1 = try self.mapStringAtKeypath(key)
        let json2 = try response.mapStringAtKeypath(key)
        let isEquel: Bool = json1 == json2
        return isEquel
    }

    func mapStringAtKeypath(_ keyPath: String) throws -> String {
        let dict = try mapJSON() as? [String: Any] ?? [:]
        if let result = dict[keyPath] {
            let data = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
            let string = String(data: data, encoding: .utf8) ?? ""
            return string
        }
        return ""
    }

    func code() throws -> Any? {
        let json = try mapJSON() as? [String: Any] ?? [:]
        if let code = json["data"] {
            return code
        }
        return nil
    }
}
