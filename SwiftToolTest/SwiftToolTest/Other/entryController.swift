//
//  entryController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/10/10.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

let JHScreenSize = UIScreen.main.bounds
let JHScreenWidth:CGFloat = UIScreen.main.bounds.size.width
let JHScreenHeight:CGFloat = UIScreen.main.bounds.size.height
let JHiPhoneX = (JHScreenWidth == 375.0 && JHScreenHeight == 812.0) ? true : false
class entryController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor(red: 200/225.0, green: 200/225.0, blue: 200/225.0, alpha: 1.0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        for index in 0..<9 {
            let entry = EntryView(frame: CGRect(x: 0, y: 100 + 50*index, width: Int(JHScreenWidth), height: 50))
            self.view.addSubview(entry)
            if (index == 0){
                entry.SetUpTitle(mainTitle: "主标题", subtitle: "副标题")
            }else if(index == 1){
                entry.SetUpTitle(mainTitle: "主标题", subtitle: "副标题", arrow: "arrow")
            }else if (index == 2){
                entry.SetUPSwitch(mainTitle: "主标题", switchOn: false) { (result) in
                    print("开关结果:\(result ?? false)")
                }
            }else if (index == 3){
                entry.SetUPTextField(mainTitle: "主标题", placeHolder: "我是placeHolder")
            }else if (index == 4){
                entry.SetUPTextField(mainTitle: "主标题", placeHolder: "我是placeHolder",arrow: "arrow")
            }else if (index == 5){
                entry.SetUPSubtitleIV(mainTitle: "主标题", SubtitleIcon: "coupon", SubtitleSize: CGSize(width: 30, height: 30), arrow: "arrow")
            }else if (index == 6){
                entry.SetUPMainIV(mainIcon: "coupon", mainSize: CGSize(width: 30, height: 30), mainTitle: "主标题", spacing: 10)
            }else if (index == 7){
                entry.SetUPMainIV(mainIcon: "coupon", mainSize: CGSize(width: 30, height: 30), mainTitle: "主标题", spacing: 20,arrow: "arrow")
            }else if (index == 8){
                entry.SetUpTitle(mainTitle: "主标题", arrow: "arrow")
            }
            entry.hitEntryViewClose = {
                print("点击事件")
            }
        }
        
        
      
        
        
    }

   

}
