//
//  STPlaceholderTextView.swift
//  a
//
//  Created by HM on 2021/9/9.
//

import UIKit

class HMPlaceholderTextView: UITextView {
     
    /// 点击两下键盘消失
    var tapTwiceDisapper: Bool = false {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapTwiceDisapperEvent))
            tap.numberOfTapsRequired = 2
            self.addGestureRecognizer(tap)
            
        }
    }
    /// 最大允许输入文本输入量
    var maxCount: Int = 0
    /// 设置placeHolder
    var placeHolder: String = ""
    /// 设置placeHolder的颜色
    var placeHolderColor: UIColor = UIColor(red: 207/255.0, green: 207/255.0, blue: 207/255.0, alpha: 1.0)
  
   
    // MARK: - 初始化
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
    }
    
   /// 初始化
   ///
   /// - Parameters:
   ///   - placeHolder: placeHolder
   ///   - placeHolderColor: placeHolderColor
   ///   - MaxCount: 限制数量
   convenience init(placeHolder: String?,
                    placeHolderColor: UIColor?,
                    maxCount: Int?) {
        self.init(frame: .zero)
        self.placeHolder = placeHolder ?? ""
        self.placeHolderColor = placeHolderColor ?? UIColor.gray
        self.maxCount = maxCount ?? 0
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
  
}

// MARK: - 方法
extension HMPlaceholderTextView {
    // 文本改变
    @objc func textDidChange() {
        self.delegate?.textViewDidChange!(self)
        self.setNeedsDisplay()
    }
    // 给textView添加点击事件
    @objc func tapTwiceDisapperEvent() {
        if self.tapTwiceDisapper == true {
            self.resignFirstResponder()
        }
    }
    
    // 绘制
    override func draw(_ rect: CGRect) {
        // 绘制placeHolder
        drawPlaceHolder(rect)
        // 绘制文本限制数量
        drawMaxCountText(rect)
    }

    // 绘制placeHolder
    func drawPlaceHolder(_ rect: CGRect) {
        guard !self.hasText else {
            return
        }
        let attrs = NSMutableDictionary.init()
        attrs.setValue(self.font, forKey: NSAttributedString.Key.font.rawValue)
        attrs.setValue(self.placeHolderColor, forKey: NSAttributedString.Key.foregroundColor.rawValue)
        let x: CGFloat  = 8.0
        let y: CGFloat  = 8.0
        let widht  = rect.size.width - 2 * x
        let height  = rect.size.height  - 2 * y
        let tempRect = CGRect.init(x: x, y: y, width: widht, height: height)
        self.placeHolder.draw(in: tempRect, withAttributes: attrs as? [NSAttributedString.Key: Any])
    }
    
    // 绘制文本限制数量
    func drawMaxCountText(_ rect: CGRect) {
        guard self.maxCount > 1 else {
            return
        }
        // 数量限制
        if text.count >= maxCount {
            text = stringByReplacing(textString: text, index: maxCount, length: text.count-maxCount, replacText: "")
        }
        
        // 文本显示
        let limitText = "\(text.count)" + "/" + "\(self.maxCount)"
        let limitFont = self.font ?? UIFont.systemFont(ofSize: 15)
        
        let attrs = NSMutableDictionary.init()
        attrs.setValue(UIColor.gray, forKey: NSAttributedString.Key.foregroundColor.rawValue)
        attrs.setValue(limitFont, forKey: NSAttributedString.Key.font.rawValue)
        // 计算文本宽度
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        let limitRect = limitText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: limitFont], context: nil)
        let width: CGFloat = limitRect.size.width + 10
        let height: CGFloat = 25
        let tempRect = CGRect.init(x: rect.size.width - width, y: rect.size.height - height, width: width, height: height)
        limitText.draw(in: tempRect, withAttributes: attrs as? [NSAttributedString.Key: Any])
  
    }
    
    
    // 字符串的替换
    func stringByReplacing(textString: String,
                           index: Int,
                           length: Int,
                           replacText: String) -> String {
        var myText = textString
        let startIndex = textString.index(textString.startIndex, offsetBy: index)
        myText.replaceSubrange(startIndex..<myText.index(startIndex, offsetBy: length), with: replacText)
        
        return myText
    }
    
}






























































