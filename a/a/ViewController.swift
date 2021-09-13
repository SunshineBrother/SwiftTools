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
         
        let str = "Created by 姜军辉 on 2021/9/7."
        let key = "123456"
 
        let result = CryptoTools.AESEncrypt(text: str, key: key)
        print(result)
        let value = CryptoTools.AESDecrypt(text: result, key: key)
        print(value)
        
        
        
    }

    
}

