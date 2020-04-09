//
//  ViewController.swift
//  局部scope
//
//  Created by yunna on 2020/4/8.
//  Copyright © 2020 yunna. All rights reserved.
//

import UIKit

func local(_ closure: ()->()) {
    closure()
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         
        
        
    }
    
    
    override func loadView() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        view.backgroundColor = .white
        
        let titleLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 150, y: 30, width: 200, height: 40))
            label.textColor = .red
            label.text = "Title"
            return label
        }()
        view.addSubview(titleLabel)
        
        let textLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 150, y: 80, width: 200, height: 40))
            label.textColor = .red
            label.text = "Text"
            return label
        }()
        view.addSubview(textLabel)
        
        self.view = view
    }
    

//    override func loadView() {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
//        view.backgroundColor = .white
//
//        local {
//            let titleLabel = UILabel(frame: CGRect(x: 150, y: 30, width: 200, height: 40))
//            titleLabel.textColor = .red
//            titleLabel.text = "Title"
//            view.addSubview(titleLabel)
//        }
//
//        local {
//            let textLabel = UILabel(frame: CGRect(x: 150, y: 80, width: 200, height: 40))
//            textLabel.textColor = .red
//            textLabel.text = "Text"
//            view.addSubview(textLabel)
//        }
//
//        self.view = view
//    }
}

