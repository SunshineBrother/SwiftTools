//
//  LocationController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/7/12.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class LocationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    @IBAction func LocationBtn(_ sender: Any) {
        LocationTool.sharedInstance.getUserCoordinate({ (coor) in
            print(coor)
        }) { (place) in
            print(place)
        }
    }
    
    

}
