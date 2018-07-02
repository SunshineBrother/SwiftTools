//
//  ThirdScrollController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/7/2.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class ThirdScrollController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView!
    var dataSource = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        //空白数据的时候
        self.tableView.addEmpty(text: "空白数据", image: "Head", offSet: 0)
        self.tableView.obtainClickClosure {
            //点击空白的回调
            print("点击空白的回调")
        }
        self.tableView.addRefreshWithScrollView(refreshHeaderClosure: {
            //头部刷新
        }) {
            //底部刷新
        }
       
       
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        
        
        
        return cell!
    }
    
    
    
    
    

}




















