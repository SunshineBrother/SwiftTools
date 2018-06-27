//
//  Extension.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/8.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
//MARK: -- 初始化 --
extension UIImage{
    /// 根据view 生成image
    public convenience init?(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
    ///根据颜色生成图片
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        guard let aCgImage = image.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
    
  
}

//MARK:-- 方法 --
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
    /// 截取指定Image的rect
    public func crop(in rect: CGRect) -> UIImage {
        guard rect.size.height < size.height && rect.size.height < size.height else { return self }
        guard let image: CGImage = cgImage?.cropping(to: rect) else { return self }
        return UIImage(cgImage: image)
    }
   ///view生成指定大小的图片
   public func WithView(view:UIView ,size:CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    ///压缩图片
    public func compressedData(quality: CGFloat = 0.5) -> Data? {
        return UIImageJPEGRepresentation(self, quality)
    }
    /// 旋转指定角度
    public func rotate(radians: Float) -> UIImage {
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let transformation: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(radians))
        rotatedViewBox.transform = transformation
        let rotatedSize: CGSize = CGSize(width: Int(rotatedViewBox.frame.size.width), height: Int(rotatedViewBox.frame.size.height))
        
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, 0)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        
        context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        
        context.rotate(by: CGFloat(radians))
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        
        guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// 根据字符串生成二维码图片
    public func generateQRImage(QRCodeString: String, logo: UIImage?, size: CGSize = CGSize(width: 200, height: 200)) -> UIImage? {
        guard let data = QRCodeString.data(using: .utf8, allowLossyConversion: false) else {
            return nil
        }
        let imageFilter = CIFilter(name: "CIQRCodeGenerator")
        imageFilter?.setValue(data, forKey: "inputMessage")
        imageFilter?.setValue("H", forKey: "inputCorrectionLevel")
        let ciImage = imageFilter?.outputImage
        
        // 创建颜色滤镜
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValue(ciImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        
        // 返回二维码图片
        let qrImage = UIImage(ciImage: (colorFilter?.outputImage)!)
        let imageRect = size.width > size.height ?
            CGRect(x: (size.width - size.height) / 2, y: 0, width: size.height, height: size.height) :
            CGRect(x: 0, y: (size.height - size.width) / 2, width: size.width, height: size.width)
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        qrImage.draw(in: imageRect)
        if logo != nil {
            let logoSize = size.width > size.height ?
                CGSize(width: size.height * 0.25, height: size.height * 0.25) :
                CGSize(width: size.width * 0.25, height: size.width * 0.25)
            logo?.draw(in: CGRect(x: (imageRect.size.width - logoSize.width) / 2, y: (imageRect.size.height - logoSize.height) / 2, width: logoSize.width, height: logoSize.height))
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
 
}



























