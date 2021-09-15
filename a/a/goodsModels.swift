//
//  Grade.swift
//  ZMClientSouTi
//
//  Created by wans on 2021/6/7.
//

import ObjectMapper

  
struct RootClass: Mappable, ObjectMappable {
    var code: String = ""
    var message: String = ""
    var count: Int = 0
    var error: Bool = false
    var specialColumnList = [RootClassSpecialColumnList]()
    var success: Bool = false

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        code   <- map["code"]
        count   <- map["count"]
        message <- map["message"]
        error   <- map["error"]
        specialColumnList   <- map["specialColumnList"]
        success   <- map["success"]
    }
}



struct RootClassSpecialColumnList: Mappable {
    var columnType: String?
    var content: String?
    var coverGoodsList = [RootClassSpecialColumnListCoverGoodsList]()
    var publishDate: Int = 0
    var publishUserId: String?
    var specialColumnId: String?
    var status: String?
    var title: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        columnType   <- map["columnType"]
        content   <- map["content"]
        coverGoodsList   <- map["coverGoodsList"]
        publishDate   <- map["publishDate"]
        publishUserId   <- map["publishUserId"]
        specialColumnId   <- map["specialColumnId"]
        status   <- map["status"]
        title   <- map["title"]
    }
}

struct RootClassSpecialColumnListCoverGoodsList: Mappable {
    var channel: String?
    var content: String?
    var coverGoods: String?
    var coverUrl: String?
    var goodsId: String?
    var publishDate: Int = 0
    var recommendId: String?
    var specialColumnId: String?
    var status: String?
    var title: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        channel   <- map["channel"]
        content   <- map["content"]
        coverGoods   <- map["coverGoods"]
        coverUrl   <- map["coverUrl"]
        goodsId   <- map["goodsId"]
        publishDate   <- map["publishDate"]
        recommendId   <- map["recommendId"]
        specialColumnId   <- map["specialColumnId"]
        status   <- map["status"]
        title   <- map["title"]
    }
}


 
