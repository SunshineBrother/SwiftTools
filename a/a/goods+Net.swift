//
//  File.swift
//  a
//
//  Created by jiangjunhui on 2021/9/14.
//

import Foundation
import RxSwift
import ObjectMapper
extension HttpServer {
    func getGoods() -> Observable<RootClass> {
        
        return request(api: UserAPI.getGoods).mapSpecialModel(RootClass.self).verifyStatus()
    }

    func getsys() -> Observable<CloudCfgModel> {
        return request(api: UserAPI.cloudCfg).mapSpecialModel(CloudCfgModel.self).verifyStatus()
    }
  
}
