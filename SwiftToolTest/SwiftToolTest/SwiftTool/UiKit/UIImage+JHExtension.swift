//
//  Extension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/8.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

extension UIImage{
    
    ///将图片绘制成制定大小
    public class func scaleTo(image: UIImage, w: CGFloat, h: CGFloat) -> UIImage {
        let newSize = CGSize(width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    ///颜色生成image
    public class func WithColor(color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor);
        context!.fill(rect)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage;
    }
    
    
   ///view生成指定大小的图片
   public class func WithView(view:UIView ,size:CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
 
}



























