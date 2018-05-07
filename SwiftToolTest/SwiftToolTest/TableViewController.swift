//
//  TableViewController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/4/28.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UITableViewController {
    ///数据源
    let dataList = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取数据源
        obtainDataSource()
    }
 
    ///获取数据源
    func obtainDataSource() {
        let filePath = Bundle.main.path(forResource: "swiftTool", ofType: "plist")
        let fileDic = NSDictionary.init(contentsOfFile: filePath!) ?? [String : Any]() as NSDictionary
        let json = JSON(fileDic)
        for (key,value) in json {
            let model = Model()
            model.Title = key
            model.detailArr = JSON(value).arrayValue
            self.dataList.add(model)
        }
  
        
    }
    
    
    
    
    
    
    
    
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.dataList[section] as! Model
        return model.detailArr.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = self.dataList[section] as! Model
        return model.Title
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        
        let model = self.dataList[indexPath.section] as! Model
        let text = model.detailArr[indexPath.row].stringValue
        cell?.textLabel?.text = text
        
        return cell!
    }
 

  

    

}
