//
//  JHTextView.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/5/10.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class JHTextView: UITextView {
    //MARK:-- 属性 --
    ///点击两下键盘消失
    var tapTwiceDisapper: Bool = false{
        didSet{
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapTwiceDisapperEvent))
            tap.numberOfTapsRequired = 2
            self.addGestureRecognizer(tap)
            
        }
    }
    ///最大允许输入文本输入量
    var MaxCount: Int = 0
    ///设置placeHolder
    var placeHolder: String = ""
    ///设置placeHolder的颜色
    var placeHolderColor: UIColor = UIColor.gray
  
   
    //MARK: -- 初始化 --
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
         NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: .UITextViewTextDidChange, object: self)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: .UITextViewTextDidChange, object: self)
    }
   /// 初始化
   ///
   /// - Parameters:
   ///   - placeHolder: placeHolder
   ///   - placeHolderColor: placeHolderColor
   ///   - MaxCount: 限制数量
   convenience init(placeHolder:String?, placeHolderColor:UIColor?,MaxCount:Int?) {
        self.init(frame: .zero)
        self.placeHolder = placeHolder ?? ""
        self.placeHolderColor = placeHolderColor ?? UIColor.gray
        self.MaxCount = MaxCount ?? 0
         NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: .UITextViewTextDidChange, object: self)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
  
}

//MARK:-- 方法 --
extension JHTextView{
    //文本改变
    @objc func textDidChange(){
        self.delegate?.textViewDidChange!(self)
        self.setNeedsDisplay()
    }
    //给textView添加点击事件
    @objc func tapTwiceDisapperEvent(){
        if self.tapTwiceDisapper == true {
            self.resignFirstResponder()
        }
    }
    
    //绘制
    override func draw(_ rect: CGRect) {
        //绘制placeHolder
        drawPlaceHolder(rect)
        //绘制文本限制数量
        drawMaxCountText(rect)
    }

    //绘制placeHolder
    func drawPlaceHolder(_ rect: CGRect)  {
        guard !self.hasText else {
            return
        }
        let attrs = NSMutableDictionary.init()
        attrs.setValue(self.font, forKey: NSAttributedStringKey.font.rawValue)
        attrs.setValue(self.placeHolderColor, forKey: NSAttributedStringKey.foregroundColor.rawValue)
        let x:CGFloat  = 8.0
        let y:CGFloat  = 8.0
        let widht  = rect.size.width - 2 * x
        let height  = rect.size.height  - 2 * y
        let tempRect = CGRect.init(x: x, y: y, width:widht, height: height)
        self.placeHolder.draw(in: tempRect, withAttributes:attrs as? [NSAttributedStringKey : Any])
    }
    
    //绘制文本限制数量
    func drawMaxCountText(_ rect: CGRect)  {
        guard self.MaxCount > 1 else {
            return
        }
        //数量限制
        if text.count >= MaxCount {
            text = stringByReplacing(textString: text, index: MaxCount, length: text.count-MaxCount, replacText: "")
        }
        
        //文本显示
        let limitText = "\(text.count)" + "/" + "\(self.MaxCount)"
        let limitFont = self.font ?? UIFont.systemFont(ofSize: 15)
        
        let attrs = NSMutableDictionary.init()
        attrs.setValue(self.textColor, forKey: NSAttributedStringKey.foregroundColor.rawValue)
        attrs.setValue(limitFont, forKey: NSAttributedStringKey.font.rawValue)
        //计算文本宽度
        let size = CGSize(width:CGFloat.greatestFiniteMagnitude, height:0)
        let limitRect = limitText.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : limitFont], context:nil)
        let width:CGFloat = limitRect.size.width + 10
        let height:CGFloat = 30
        let tempRect = CGRect.init(x: rect.size.width - width, y: rect.size.height - height, width:width, height: height)
        limitText.draw(in: tempRect, withAttributes:attrs as? [NSAttributedStringKey : Any])
  
    }
    
    
    //字符串的替换
    func stringByReplacing(textString:String,index:Int,length:Int,replacText:String) -> String {
        var TEXT = textString
        let startIndex = textString.index(textString.startIndex, offsetBy: index)
        TEXT.replaceSubrange(startIndex..<TEXT.index(startIndex, offsetBy: length), with: replacText)
        
        return TEXT
    }
    
}






























































