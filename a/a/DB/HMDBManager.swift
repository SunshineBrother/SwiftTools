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

let db = HMDBManager.share

class HMDBManager: NSObject {
    
    static let share = HMDBManager()
    
    let dataBasePath = URL(fileURLWithPath: KDBPath().dbPath)
    var dataBase: Database?
    private override init() {
        super.init()
        dataBase = createDb()
        createTable(table: .baseTable, of: HMBaseTableModel.self)
    }
    /// 创建db
    private func createDb() -> Database {
        debugPrint("数据库路径==\(dataBasePath.absoluteString)")
        return Database(withFileURL: dataBasePath)
    }
    
    /// 创建表
    func createTable<T: TableDecodable>(table: HMDBTableNames,
                                        of ttype: T.Type) {
        do {
            try dataBase?.create(table: table.rawValue, of: ttype)
        } catch let error {
            debugPrint("create table error \(error.localizedDescription)")
        }
    }
    
    /// 插入
    /// 插入操作有 "insert" 和 "insertOrReplace" 两个接口
    /// 前者只是单纯的插入数据，当数据出现冲突时会失败
    /// 后者在主键冲突等约束冲突出现时，新数据会覆盖旧数据
    func insertToDb<T: TableEncodable>(objects: [T],
                                       intoTable table: HMDBTableNames) {
        do {
            try dataBase?.insert(objects: objects, intoTable: table.rawValue)
        } catch let error {
            debugPrint(" insert obj error \(error.localizedDescription)")
        }
    }
    /// 插入 键冲突等约束冲突出现时，新数据会覆盖旧数据
    func insertOrReplaceToDb<T: TableEncodable>(objects: [T],
                                                intoTable table: HMDBTableNames) {
        do {
            try dataBase?.insertOrReplace(objects: objects, intoTable: table.rawValue)
        } catch let error {
            debugPrint(" insert obj error \(error.localizedDescription)")
        }
    }
    
    
    /*
     qureyFromDb(fromTable: .baseTable, cls: HMBaseTableModel.self, where: HMBaseTableModel.Properties.key.like("2343"))
     qureyFromDb(fromTable: .baseTable, cls: HMBaseTableModel.self, where: HMBaseTableModel.Properties.identifier.intValue ?? 0 > 0)
     */
    /// 查询
    /// - Parameters:
    ///   - fromTable: 表名
    ///   - cName: model类型
    ///   - condition: 符合删除的条件
    ///   - orderList: 排序的方式
    /// - Returns:
    func qureyFromDb<T: TableDecodable>(fromTable: HMDBTableNames,
                                        cls cName: T.Type,
                                        where condition: Condition? = nil,
                                        orderBy orderList: [OrderBy]? = nil) -> [T] {
        do {
            let allObjects: [T] = try (dataBase?.getObjects(fromTable: fromTable.rawValue, where: condition, orderBy: orderList))!
            return allObjects
        } catch let error {
            debugPrint("no data find \(error.localizedDescription)")
        }
        return []
    }
    
    
    /*
     model.key = "kkkkk"
     model.data = "ss"
     db.updateToDb(table: .baseTable, on: HMBaseTableModel.Properties.all, with: model, where: HMBaseTableModel.Properties.key.like("2343"))
     
     
     model.key = "key"
     db.updateToDb(table: .baseTable, on: [HMBaseTableModel.Properties.key], with: model, where: HMBaseTableModel.Properties.key.like("123"))
     */
    /// 修改
    /// - Parameters:
    ///   - table: 表名
    ///   - propertyConvertibleList: propertyConvertibleList
    ///   - object: model对象
    ///   - condition: 符合删除的条件
    ///   - orderList: 排序的方式
    ///   - limit: 删除的个数
    ///   - offset: 从第几个开始删除
    func updateToDb<T: TableEncodable>(
        table: HMDBTableNames,
        on propertyConvertibleList: [PropertyConvertible],
        with object: T,
        where condition: Condition,
        orderBy orderList: [OrderBy]? = nil,
        limit: Limit? = nil,
        offset: Offset? = nil) {
        do {
            try dataBase?.update(table: table.rawValue, on: propertyConvertibleList, with: object, where: condition, orderBy: orderList, limit: limit, offset: offset)
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
    func delete(fromTable table: HMDBTableNames,
                where condition: Condition? = nil,
                orderBy orderList: [OrderBy]? = nil,
                limit: Limit? = nil,
                offset: Offset? = nil) {
        do {
            try dataBase?.delete(fromTable: table.rawValue, where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch let error {
            debugPrint("delete error \(error.localizedDescription)")
        }
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


