//
//  File.swift
//  a
//
//  Created by jiangjunhui on 2021/9/14.
//

import Foundation
import Moya
 
private let kGetGoods = "/cloudpick/rest/api/v1/dis/column/query"
private let kcloudCfg = "/sto/rest/admin/api/v1/cloud/cfg"

private let krefreshToken = "/zmc-puzzle-user/api/userInfo/update/grade"
 
enum UserAPI {
    case getGoods
    case refreshToken
    case cloudCfg
}



extension UserAPI: HMTargetType {
    
    
    var encoding: ParameterEncoding {
        switch self {
        case .getGoods, .cloudCfg:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
         
    }
    
    var policy: CachePolicy {
        switch self {
        case .getGoods, .cloudCfg:
            return .firstCache
        default:
            return .none
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getGoods:
            return ["pageNum": 1, "pageSize": 10, "columnType": "NEW_PRODUCT", "channel": "yunna"]
        case .cloudCfg:
            return [:]
        case .refreshToken:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .getGoods:
            return kGetGoods
        case .cloudCfg:
            return kcloudCfg
        case .refreshToken:
            return krefreshToken
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGoods, .cloudCfg:
            return .get
        default:
            return .post
        }
    }
    
    var baseURL: URL {
        return URL(string: "http://www.yunatop.com")!
    }
    
    
    
}

