//
//  MBProgressHUDController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/6/29.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class MBProgressHUDController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        JHProgressHUD.Showloading()
        JHProgressHUD.Showloading()
        JHProgressHUD.Showloading()
        JHProgressHUD.Showloading()
        
        delay(3) {
            JHProgressHUD.dismissHUD()
        }
    }

    
    @IBAction func Test1(_ sender: Any) {
        
    }
    
    
    @IBAction func Test2(_ sender: Any) {
        
    }
    
    
    @IBAction func Test3(_ sender: Any) {
        
    }
    
    
    
    @IBAction func Test4(_ sender: Any) {
         
    }
    

}

















