//
//  String+HMExtension.swift
//  a
//
//  Created by HM on 2021/9/9.
//



import UIKit


// MARK: - 字符串的拆分 --
extension String {
    /// 根据下标获取某个下标字符
    subscript(index: Int) -> String {
        if index < 0 || index > self.count {
            assert(false, "Index out of range")
        }
        for (i, item) in self.enumerated() where index == i {
            return "\(item)"
        }
        return ""
    }
    
    /// 获取range范围内的字符串
    subscript(range: NSRange) -> String {
        let location = range.location
        let length = range.length
        if location < 0 || location + length > self.count {
            assert(false, "Index out of range")
        }
        
        var text = ""
        for (index, item) in self.enumerated() where index >= location && index < location + length {
            text += "\(item)"
        }

        return text
    }
    
    ///  字符串的截取
    public func substring(from: Int,
                          to: Int) -> String {
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(startIndex, offsetBy: to)
        
        guard fromIndex >= startIndex, fromIndex < toIndex, toIndex <= endIndex else { return "" }
        
        return String(self[fromIndex ..< toIndex])
    }
   
    
    /// 替换指定范围内的字符串
    mutating func stringByReplacingCharactersInRange(index: Int,
                                                     length: Int,
                                                     replacText: String) {
        let startIndex = self.index(self.startIndex, offsetBy: index)
        self.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: length), with: replacText)
    }
    /// 替换指定字符串
    mutating func stringByReplacingstringByReplacingString(text: String,
                                                           replacText: String) {
         self = self.replacingOccurrences(of: text, with: replacText)
    }
  
    /// 删除最后一个字符
    mutating func deleteEndCharacters() {
        self.remove(at: self.index(before: self.endIndex))
    }
    /// 删除指定字符串
    mutating func deleteString(string: String) -> String {
        return self.replacingOccurrences(of: string, with: "")
    }
    
    /// 字符的插入
    mutating func insertString(text: Character,
                               index: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: index)
        self.insert(text, at: start)
        return self
    }
    /// 字符串的插入
    mutating func insertString(text: String,
                               index: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: index)
        self.insert(contentsOf: text, at: start)
        return self
    }
    
    /// 将字符串通过特定的字符串拆分为字符串数组
    ///
    /// - Parameter string: 拆分数组使用的字符串
    /// - Returns: 字符串数组
    public func split(string: String) -> [String] {
        return NSString(string: self).components(separatedBy: string)
    }
    
    /// 去空格
    public func removeAllSapce() -> String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }

    /// 获取某个字符串在总字符串的位置
    public func positionOf(sub: String,
                           backwards: Bool = false) -> Int {
        var pos = -1
        if let range = range(of: sub, options: backwards ? .backwards : .literal) {
            if !range.isEmpty {
                pos = self.distance(from: startIndex, to: range.lowerBound)
            }
        }
        return pos
    }
    
    /// 获取字符串的范围
    public
    func rangeOfString(sub: String) -> NSRange {
        var pos = -1
        if let range = range(of: sub, options: .backwards) {
            if !range.isEmpty {
                pos = self.distance(from: startIndex, to: range.lowerBound)
            }
        }
        let range1 = NSRange(location: pos, length: sub.count)
        return range1
    }
    
    
}


// MARK: - 获取文本的宽高 --
extension String {
    /// 获取文本高度
    ///
    /// - Parameters:
    ///   - font: font
    ///   - fixedWidth: fixedWidth
    func getHeight(font: UIFont = UIFont.systemFont(ofSize: 17),
                   fixedWidth: CGFloat) -> CGFloat {
        
        guard self.count > 0 && fixedWidth > 0 else {
            return 0
        }
        
        let size = CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return rect.size.height
    }
    
    
    /// 获取文本宽度
    ///
    /// - Parameter font: font
    func getWidth(font: UIFont = UIFont.systemFont(ofSize: 17)) -> CGFloat {
        
        guard self.count > 0 else {
            return 0
        }
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return rect.size.width
    }
    
}

 
// MARK: - 根据字符串生成类
extension String {
    func toClass() -> UIViewController? {
        let nameSpace = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        guard let cls = NSClassFromString(nameSpace + "." + self) as? NSObject.Type else {
            return nil
        }
        
        guard let mapCls = cls.init() as? UIViewController else {
            return nil
        }
        return mapCls
    }
}












