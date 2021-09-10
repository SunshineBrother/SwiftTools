//
//  HMDBManager.swift
//  a
//
//  Created by HM on 2021/9/9.
//
/*
 https://blog.csdn.net/kyl282889543/article/details/100538486
 */

import Foundation
import WCDBSwift

private struct KDBPath {
    let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                     .userDomainMask,
                                                     true).last! + "/app/HMDB.db"
}


class HMDBManager: NSObject {
    
    static let share = HMDBManager()
    
    let dataBasePath = URL(fileURLWithPath: KDBPath().dbPath)
    var dataBase: Database?
    private override init() {
        super.init()
        dataBase = createDb()
        createTable(table: HMDBTableNames.baseTable.rawValue, of: HMBaseTableModel.self)
    }
    /// 创建db
    private func createDb() -> Database {
        debugPrint("数据库路径==\(dataBasePath.absoluteString)")
        return Database(withFileURL: dataBasePath)
    }
    
    /// 创建表
    func createTable<T: TableDecodable>(table: String,
                                        of ttype: T.Type) {
        do {
            try dataBase?.create(table: table, of: ttype)
        } catch let error {
            debugPrint("create table error \(error.localizedDescription)")
        }
    }
    
    /// 插入
    /// 插入操作有 "insert" 和 "insertOrReplace" 两个接口
    /// 前者只是单纯的插入数据，当数据出现冲突时会失败
    /// 后者在主键冲突等约束冲突出现时，新数据会覆盖旧数据
    func insertToDb<T: TableEncodable>(objects: [T],
                                       intoTable table: String) {
        do {
            try dataBase?.insert(objects: objects, intoTable: table)
        } catch let error {
            debugPrint(" insert obj error \(error.localizedDescription)")
        }
    }
    /// 插入 键冲突等约束冲突出现时，新数据会覆盖旧数据
    func insertOrReplaceToDb<T: TableEncodable>(objects: [T],
                                                intoTable table: String) {
        do {
            try dataBase?.insertOrReplace(objects: objects, intoTable: table)
        } catch let error {
            debugPrint(" insert obj error \(error.localizedDescription)")
        }
    }
    
    
    
    /// 修改
    func updateToDb<T: TableEncodable>(table: String,
                                       on propertys: [PropertyConvertible],
                                       with object: T,
                                       where condition: Condition? = nil) {
        do {
            try dataBase?.update(table: table, on: propertys, with: object, where: condition)
        } catch let error {
            debugPrint(" update obj error \(error.localizedDescription)")
        }
    }
    
    
    /// 删除
    /**
     func delete(fromTable table: String, // 表名
                 where condition: Condition? = nil, // 符合删除的条件
                 orderBy orderList: [OrderBy]? = nil, // 排序的方式
                 limit: Limit? = nil, // 删除的个数
                 offset: Offset? = nil // 从第几个开始删除
     ) throws
     
     删除 sampleTable 中所有 identifier 大于 1 的行的数据
     try database.delete(fromTable: "sampleTable",
                         where: Sample.Properties.identifier > 1)
     */
    func deleteFromDb(fromTable: String,
                      where condition: Condition? = nil) {
        do {
            try dataBase?.delete(fromTable: fromTable, where: condition)
        } catch let error {
            debugPrint("delete error \(error.localizedDescription)")
        }
    }
    
    /// 查询
    func qureyFromDb<T: TableDecodable>(fromTable: String,
                                        cls cName: T.Type,
                                        where condition: Condition? = nil,
                                        orderBy orderList: [OrderBy]? = nil) -> [T]? {
        do {
            let allObjects: [T] = try (dataBase?.getObjects(fromTable: fromTable, where: condition, orderBy: orderList))!
            debugPrint("\(allObjects)")
            return allObjects
        } catch let error {
            debugPrint("no data find \(error.localizedDescription)")
        }
        return nil
    }
    
    /// 删除数据表
    func dropTable(table: String) {
        do {
            try dataBase?.drop(table: table)
        } catch let error {
            debugPrint("drop table error \(error)")
        }
    }
    
    /// 删除所有与该数据库相关的文件
    func removeDbFile() {
        do {
            try dataBase?.close(onClosed: {
                try dataBase?.removeFiles()
            })
        } catch let error {
            debugPrint("not close db \(error)")
        }
    }
}


extension HMDBManager {
    /// insert 和 insertOrReplace 函数只有函数名不同，其他参数都一样。
    /// - Parameters:
    ///   - objects: 需要插入的对象。WCDB Swift 同时实现了可变参数的版本，因此可以传入一个数组，也可以传入一个或多个对象。
    ///   - propertyConvertibleList: 需要插入的字段
    ///   - table: 表名
    func insert<T: TableEncodable>(objects: [T],
                                   on propertyConvertibleList: [PropertyConvertible]? = nil,
                                   intoTable table: String
        ) {
        do {
            try dataBase?.insert(objects: objects, on: propertyConvertibleList, intoTable: table)
        } catch let error {
            debugPrint(" insert obj error \(error.localizedDescription)")
        }
    }
    
    // 更新
    func update<T: TableEncodable>(
        table: String,
        on propertyConvertibleList: [PropertyConvertible],
        with object: T,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) {
        do {
            try dataBase?.update(table: table, on: propertyConvertibleList, with: object, where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch let error {
            debugPrint(" update obj error \(error.localizedDescription)")
        }
    }
    
    /// 删除
    /// - Parameters:
    ///   - table: 表名
    ///   - condition: 符合删除的条件
    ///   - orderList: 排序的方式
    ///   - limit: 删除的个数
    ///   - offset: 从第几个开始删除
    func delete(fromTable table: String,
                where condition: Condition? = nil,
                orderBy orderList: [OrderBy]? = nil,
                limit: Limit? = nil,
                offset: Offset? = nil) {
        do {
            try dataBase?.delete(fromTable: table, where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch let error {
            debugPrint("delete error \(error.localizedDescription)")
        }
    }
    

    
    /// 查询
    /// - Parameters:
    ///   - propertyConvertibleList: <#propertyConvertibleList description#>
    ///   - table: <#table description#>
    ///   - condition: <#condition description#>
    ///   - orderList: <#orderList description#>
    ///   - limit: <#limit description#>
    ///   - offset: <#offset description#>
    /// - Returns: <#description#>
    func getObjects<T: TableDecodable>(
        on propertyConvertibleList: [PropertyConvertible],
        fromTable table: String,
        where condition: Condition? = nil,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) -> [T]? {
        var list: [T]?
        do {
            try list = dataBase?.getObjects(on: propertyConvertibleList, fromTable: table, where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch let error {
            debugPrint("getObjects error \(error.localizedDescription)")
        }
        return list
    }
}
