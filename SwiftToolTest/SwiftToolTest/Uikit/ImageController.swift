//
//  ImageController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/30.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class ImageController: UIViewController {

    @IBOutlet weak var IV1: UIImageView!
    
    
    @IBOutlet weak var IV2: UIImageView!
    
    @IBOutlet weak var IV3: UIImageView!
    
    @IBOutlet weak var IV4: UIImageView!
    
    @IBOutlet weak var IV5: UIImageView!
    

    @IBOutlet weak var IV6: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
    }

    
    
    
    @IBAction func button1(_ sender: Any) {
        self.IV1.image = UIImage.init(color: UIColor.red, size: CGSize(width: 50, height: 50))
    }
    
    
    
    @IBAction func button2(_ sender: Any) {
        let image = self.IV4.image!.crop(in: CGRect(x: 110, y: 110, width: 50, height: 50))
        self.IV2.image = image
    }
    
    
    
    @IBAction func button3(_ sender: Any) {
        self.IV3.image = UIImage().WithView(view: self.IV4, size: CGSize(width: 60, height: 60))
    }
    
    
   
    
    @IBAction func button4(_ sender: Any) {
        let image = self.IV4.image
        self.IV4.image = image?.rotate(radians: .pi/4)
        
    }
    
    
    
 
    @IBAction func button5(_ sender: Any) {
        self.IV5.image = UIImage().generateQRImage(QRCodeString: "test", logo: nil)
    }
    
    
    
    @IBAction func button6(_ sender: Any) {
    }
    
    
    
    
    
}
