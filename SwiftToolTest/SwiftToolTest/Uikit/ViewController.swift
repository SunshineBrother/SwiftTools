//
//  ViewController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/22.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var View1: UIView!
    
    @IBOutlet weak var View2: UIView!
    
    @IBOutlet weak var IV: UIImageView!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        View1.addCornerRadius(radius: 10)
        View1.addBorder(width: 3, color: UIColor.red)
        
        View2.addBorderBottom(size: 3, color: UIColor.red)
        View2.cutSemicircle(roundingCorners: [.bottomRight,.topRight] , cornerRadii: CGSize(width: View2.h / 2, height: View2.h / 2))
        
        
        let image = View2.toImage()
        IV.image = image
        
        
        
        
    }

  

}


















