//
//  RootClass.swift
//
//
//  Created by JSONConverter on 2021/09/14.
//  Copyright © 2021年 JSONConverter. All rights reserved.
//

import Foundation
import ObjectMapper

struct CloudCfgModel: Mappable, ObjectMappable {
    var code: String = ""
    var message: String = ""
    var cloudCfgList: RootClassCloudCfgList?
    var error: Bool = false
    var success: Bool = false

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        cloudCfgList   <- map["cloudCfgList"]
        code   <- map["code"]
        error   <- map["error"]
        success   <- map["success"]
        message <- map["message"]
    }
}

struct RootClassCloudCfgList: Mappable {
    var cloudName: String?
    
    var countryCode: String?
    var currencyDecimals: String?
    var discount: String?
    var docHost: String?
    
    var gameHost: String?
    var imgHost: String?
    var lang: String?
    var langHost: String?
    var languages: String?
    var nationalFlag: String?
    var needI18nConversion: String?
    var sms: String?
    var timeZone: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        cloudName   <- map["cloudName"]
        
        countryCode   <- map["countryCode"]
        currencyDecimals   <- map["currencyDecimals"]
        discount   <- map["discount"]
        docHost   <- map["docHost"]
        
        gameHost   <- map["gameHost"]
        imgHost   <- map["imgHost"]
        lang   <- map["lang"]
        langHost   <- map["langHost"]
        languages   <- map["languages"]
        nationalFlag   <- map["nationalFlag"]
        needI18nConversion   <- map["needI18nConversion"]
        sms   <- map["sms"]
        timeZone   <- map["timeZone"]
    }
}
