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

         
    }

    
    @IBAction func Test1(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        if self.callBackClose != nil{
            self.callBackClose!("123456789")
        }
    }
    
    
    @IBAction func Test2(_ sender: Any) {
        
    }
    
    
    @IBAction func Test3(_ sender: Any) {
        
    }
    
    
    
    @IBAction func Test4(_ sender: Any) {
         
    }
    

}

















