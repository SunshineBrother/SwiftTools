//
//  Sample.swift
//  a
//
//  Created by HM on 2021/9/9.
/*
 https://blog.csdn.net/kyl282889543/article/details/100538486
 */


import WCDBSwift

class HMBaseTableModel: TableCodable {
    var key: String = ""
    var data: String = ""
    
    
    // 对于不需要写入数据库的字段，则不需要在 CodingKeys 内定义
    /// 即便是所有字段都需要绑定，这里也必须列举每一个需要绑定的字段
    enum CodingKeys: String, CodingTableKey {
        typealias Root = HMBaseTableModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case key
        case data
       
        
        // 字段约束是 TableEncodable 的一个可选函数，可根据需求选择实现或不实现。它用于定于针对单个字段的约束，如主键约束、非空约束、唯一约束、默认值等。
        /**
         ColumnConstraintBinding(
             isPrimary: Bool = false, // 该字段是否为主键。字段约束中只能同时存在一个主键
             orderBy term: OrderTerm? = nil, // 当该字段是主键时，存储顺序是升序还是降序
             isAutoIncrement: Bool = false, // 当该字段是主键时，其是否支持自增。只有整型数据可以定义为自增。
             onConflict conflict: Conflict? = nil, // 当该字段是主键时，若产生冲突，应如何处理
             isNotNull: Bool = false, // 该字段是否可以为空
             isUnique: Bool = false, // 该字段是否可以具有唯一性
             defaultTo defaultValue: ColumnDef.DefaultType? = nil // 该字段在数据库内使用什么默认值
         )
         */
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [:]
        }
    }
    
    public var isAutoIncrement: Bool = true    /// 用于定义是否使用自增的方式插入
    public var lastInsertedRowID: Int64 = 0     /// 用于获取自增插入后的主键值
}
