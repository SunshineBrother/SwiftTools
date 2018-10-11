//
//  PopMenuController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/10/11.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class PopMenuController: UIViewController {
    //店铺选择下拉列表
    var popMenu: SwiftPopMenu!
    //下拉列表数组
    var popMenuList:[(icon:String,title:String)]! = [(icon:String,title:String)]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.setTitle("button", for: .normal)
        btn.backgroundColor = UIColor.gray
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
        
        
        popMenuList.append((icon: "", title: "测试1"))
        popMenuList.append((icon: "", title: "测试2"))
        popMenuList.append((icon: "", title: "测试3"))
        popMenuList.append((icon: "", title: "测试4"))
        
        self.popMenu = SwiftPopMenu(frame: CGRect(x: 130, y: 210, width: 80, height: 200))
        self.popMenu.popData = popMenuList
    }

    @objc func buttonEvent(){
        //点击菜单
        self.popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
            
        }
        self.popMenu.show()
    }
}





















