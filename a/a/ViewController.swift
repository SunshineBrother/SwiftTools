//
//  ViewController.swift
//  a
//
//  Created by 姜军辉 on 2021/9/7.
//

import UIKit
import CryptoSwift
class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let str = "的一个可选函数，可根据需求选择实现或不实现。它用于定于针对单个字段的约束，如主键约束、非空约束、唯一约束、默认值等"
        
       
        //
        let model = HMBaseTableModel()
        model.key = "2343"
        model.data = str
        HMDBManager.share.insertOrReplaceToDb(objects: [model], intoTable: .baseTable)
        
        
        // 查询
        let data = HMDBManager.share.qureyFromDb(fromTable: .baseTable, cls: HMBaseTableModel.self, where: HMBaseTableModel.Properties.key.like("2343"))

        print(data.count)
        
        
        // 修改
        model.key = "kkkkk"
        model.data = "ss"
        db.updateToDb(table: .baseTable, on: HMBaseTableModel.Properties.all, with: model, where: HMBaseTableModel.Properties.key.like("2343"))
        
        
        model.key = "key"
        db.updateToDb(table: .baseTable, on: [HMBaseTableModel.Properties.key], with: model, where: HMBaseTableModel.Properties.key.like("123"))
        
 
        
    }

    
}

