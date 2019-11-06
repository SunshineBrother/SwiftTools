//
//  ViewController.swift
//  逃逸闭包
//
//  Created by yunna on 2019/11/6.
//  Copyright © 2019 yunna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         
        handleData { (data) in
            print("闭包返回结果:\(data)")
        }
        
         
    }

    func handleData(closure:(Any) -> Void) {
        print("函数开始执行--\(Thread.current)")
        print("执行了闭包---\(Thread.current)")
        closure("123")
        print("函数执行结束---\(Thread.current)")
    }
    
    
    func getData(closure:@escaping (Any) -> Void) {
        print("函数开始执行--\(Thread.current)")
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                print("执行了闭包---\(Thread.current)")
                closure("345")
            })
        }
        print("函数执行结束---\(Thread.current)")
    }
}

