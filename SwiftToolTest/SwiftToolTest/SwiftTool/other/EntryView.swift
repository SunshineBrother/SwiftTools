
//
//  EntryView.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/10/10.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class EntryView: UIView {
    ///主标题
    var mainLabel = UILabel()
    ///副标题
    var subtitleLabel = UILabel()
    ///主图片（左边图片）
    var mainIV = UIImageView()
    ///副图片（右边图片）
    var subtitleIV = UIImageView()
    ///箭头
    var arrowIV = UIImageView()
    ///右边为UISwitch
    var mySwitch = UISwitch()
    ///右边为UITextField
    var myTF = UITextField()
    //分界线
    lazy var lineView: UIView = {
        let viewW = self.bounds.size.width
        let viewH = self.bounds.size.height
        let line = UIView(frame: CGRect(x: 0, y: viewH-1, width: viewW, height: 1))
        line.backgroundColor = RGB(r: 200, g: 200, b: 200)
        return line
    }()
    ///是否显示lineView
    var showLine = true{
        didSet{
            self.lineView.isHidden = !showLine
        }
    }
    ///点击事件的回调
    var hitEntryViewClose:(()->())!
    //开关按钮的回调 true为开 false为关
    private var MySwitchClose:((Bool)->())!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addHitEntryView()
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
        
        addHitEntryView()
    }
    
    //添加点击事件
    func addHitEntryView()  {
        let hit = UITapGestureRecognizer(target: self, action: #selector(HitEntryViewEvent))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(hit)
    }
    
    
    
}

//MARK:主标题&副标题&多一个箭头
extension EntryView{
    
    ///主标题&副标题
    func SetUpTitle(mainTitle:String,subtitle:String) {
        self.backgroundColor = UIColor.white
        let viewW = self.bounds.size.width
        let viewH = self.bounds.size.height
        //主标题
        let mainW = obtainTextWidth(text: mainTitle) + 20
        mainLabel.text = mainTitle
        mainLabel.frame = CGRect(x: 20, y: 0, width: mainW, height: viewH)
        self.addSubview(mainLabel)
        
        //副标题
        let subW = viewW - mainW
        subtitleLabel.text = subtitle
        subtitleLabel.frame = CGRect(x: mainW + 20, y: 0, width: subW-40, height: viewH)
        subtitleLabel.textAlignment = .right
        self.addSubview(subtitleLabel)
      
        //分界线
        self.addSubview(self.lineView)
    }
    
    ///主标题&副标题&箭头
    func SetUpTitle(mainTitle:String,subtitle:String,arrow:String,size:CGSize = CGSize(width: 10, height: 20)) {
        self.backgroundColor = UIColor.white
        let viewW = self.bounds.size.width
        let viewH = self.bounds.size.height
        
        //主标题
        let mainW = obtainTextWidth(text: mainTitle) + 20
        mainLabel.text = mainTitle
        mainLabel.frame = CGRect(x: 20, y: 0, width: mainW, height: viewH)
        self.addSubview(mainLabel)
        
        //箭头
        arrowIV.frame = CGRect(x: viewW - 20 - size.width, y: (viewH - size.height)/2, width: size.width, height: size.height)
        arrowIV.image = UIImage.init(named: arrow)
        self.addSubview(arrowIV)
        
        //副标题
        let subtitleX = mainW + 30
        let subtitleW = viewW - subtitleX - size.width - 25
        subtitleLabel.text = subtitle
        subtitleLabel.frame = CGRect(x: subtitleX, y: 0, width: subtitleW, height: viewH)
        subtitleLabel.textAlignment = .right
        self.addSubview(subtitleLabel)
        
        //分界线
        self.addSubview(self.lineView)
      
    }
    
    /// 主标题*&箭头
    ///
    /// - Parameters:
    ///   - mainTitle: mainTitle
    ///   - arrow: arrow
    ///   - size: size
    func SetUpTitle(mainTitle:String,arrow:String,size:CGSize = CGSize(width: 10, height: 20)){
        self.backgroundColor = UIColor.white
        let viewW = self.bounds.size.width
        let viewH = self.bounds.size.height
        
        //主标题
        let mainW = obtainTextWidth(text: mainTitle) + 20
        mainLabel.text = mainTitle
        mainLabel.frame = CGRect(x: 20, y: 0, width: mainW, height: viewH)
        self.addSubview(mainLabel)
        
        //箭头
        arrowIV.frame = CGRect(x: viewW - 20 - size.width, y: (viewH - size.height)/2, width: size.width, height: size.height)
        arrowIV.image = UIImage.init(named: arrow)
        self.addSubview(arrowIV)
        
        //分界线
        self.addSubview(self.lineView)
    }
    /// 主标题&开关按钮
    ///
    /// - Parameters:
    ///   - mainTitle: 主标题
    ///   - switchOn: 当前开关状态
    ///   - SwitchClose: 开关回调
    func SetUPSwitch(mainTitle:String,switchOn:Bool,SwitchClose:@escaping (_ result : Bool?) -> ()) {
        self.backgroundColor = UIColor.white
        let viewW = self.bounds.size.width
        let viewH = self.bounds.size.height
        
        //主标题
        let mainW = obtainTextWidth(text: mainTitle) + 20
        mainLabel.text = mainTitle
        mainLabel.frame = CGRect(x: 20, y: 0, width: mainW, height: viewH)
        self.addSubview(mainLabel)
        
        //开关
        mySwitch.frame = CGRect(x: viewW - 71, y: (viewH - 31)/2, width: 51, height: 31)
        mySwitch.setOn(switchOn, animated: true)
        self.addSubview(mySwitch)
        //添加开关事件
        mySwitch.addTarget(self, action: #selector(valueChanged(mySwitch:)), for: .valueChanged)
        self.MySwitchClose = SwitchClose
        
        //分界线
        self.addSubview(self.lineView)
    }
    
    
    /// 主标题&UITextfield
    ///
    /// - Parameters:
    ///   - mainTitle: 主标题
    ///   - placeHolder: placeHolder
    func SetUPTextField(mainTitle:String,placeHolder:String) {
        self.backgroundColor = UIColor.white
        let viewW = self.bounds.size.width
        let viewH = self.bounds.size.height
        
        //主标题
        let mainW = obtainTextWidth(text: mainTitle) + 20
        mainLabel.text = mainTitle
        mainLabel.frame = CGRect(x: 20, y: 0, width: mainW, height: viewH)
        self.addSubview(mainLabel)
        
        //uitextField
        let subW = viewW - mainW
        myTF.frame = CGRect(x: mainW + 20, y: 0, width: subW-40, height: viewH)
        myTF.placeholder = placeHolder
        let label:UILabel = myTF.value(forKey: "_placeholderLabel") as! UILabel
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(myTF)
        myTF.textAlignment = .right
        //分界线
        self.addSubview(self.lineView)
    }
    
    /// 主标题&UITextfield&箭头
    ///
    /// - Parameters:
    ///   - mainTitle: 主标题
    ///   - placeHolder: placeHolder
    ///   - arrow: 箭头
    func SetUPTextField(mainTitle:String,placeHolder:String,arrow:String,size:CGSize = CGSize(width: 10, height: 20)) {
        
        self.backgroundColor = UIColor.white
        let viewW = self.bounds.size.width
        let viewH = self.bounds.size.height
        
        //主标题
        let mainW = obtainTextWidth(text: mainTitle) + 20
        mainLabel.text = mainTitle
        mainLabel.frame = CGRect(x: 20, y: 0, width: mainW, height: viewH)
        self.addSubview(mainLabel)
        
        //箭头
        arrowIV.frame = CGRect(x: viewW - 20 - size.width, y: (viewH - size.height)/2, width: size.width, height: size.height)
        arrowIV.image = UIImage.init(named: arrow)
        self.addSubview(arrowIV)
        
        //副标题
        let TFX = mainW + 30
        let TFW = viewW - TFX - size.width - 25
        myTF.frame = CGRect(x: TFX, y: 0, width: TFW, height: viewH)
        myTF.placeholder = placeHolder
        let label:UILabel = myTF.value(forKey: "_placeholderLabel") as! UILabel
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(myTF)
        myTF.textAlignment = .right
        //分界线
        self.addSubview(self.lineView)
        
    }
    
    /// 主标题，右侧图片，箭头
    ///
    /// - Parameters:
    ///   - mainTitle: mainTitle
    ///   - SubtitleIcon: 副图片
    ///   - SubtitleSize: 大小
    ///   - arrow: 箭头
    func SetUPSubtitleIV(mainTitle:String,SubtitleIcon:String,SubtitleSize:CGSize,arrow:String? = nil,size:CGSize = CGSize(width: 10, height: 20)) {
        self.backgroundColor = UIColor.white
        let viewW = self.bounds.size.width
        let viewH = self.bounds.size.height
        
        //主标题
        let mainW = obtainTextWidth(text: mainTitle) + 20
        mainLabel.text = mainTitle
        mainLabel.frame = CGRect(x: 20, y: 0, width: mainW, height: viewH)
        self.addSubview(mainLabel)
        
        //副图片
        let arrowW = arrow == nil ? 0 : size.width
        let SubtitleIVX = viewW - 20 - arrowW - 5 - SubtitleSize.width
        subtitleIV.frame = CGRect(x: SubtitleIVX, y: (viewH - SubtitleSize.height)/2, width: SubtitleSize.width, height: SubtitleSize.height)
        subtitleIV.image = UIImage.init(named: SubtitleIcon)
        self.addSubview(subtitleIV)
        
        //箭头
        arrowIV.frame = CGRect(x: viewW - 20 - size.width, y: (viewH - size.height)/2, width: size.width, height: size.height)
        arrowIV.image = UIImage.init(named: arrow ?? "")
        self.addSubview(arrowIV)
        
        
        //分界线
        self.addSubview(self.lineView)
        
    }
  
}
//MARK:左侧有图片
extension EntryView{
 
    /// 左侧图片，标题
    ///
    /// - Parameters:
    ///   - mainIcon: 左侧图片
    ///   - mainSize: size
    ///   - mainTitle: 标题
    ///   - spacing: 间隔
    func SetUPMainIV(mainIcon:String,mainSize:CGSize,mainTitle:String,spacing:CGFloat,arrow:String? = nil,size:CGSize = CGSize(width: 10, height: 20)) {
        self.backgroundColor = UIColor.white
        let viewW = self.bounds.size.width
        let viewH = self.bounds.size.height
        
        //左侧图片
        mainIV.frame = CGRect(x: 20, y: (viewH-mainSize.height)/2, width: mainSize.width, height: mainSize.height)
        mainIV.image = UIImage.init(named: mainIcon)
        self.addSubview(mainIV)
        
        
        //标题
        let mainLabelX = 20 + mainSize.width + spacing
        mainLabel.frame = CGRect(x: mainLabelX, y: 0, width: viewW - mainLabelX - 50, height: viewH)
        mainLabel.text = mainTitle
        self.addSubview(mainLabel)
        
        //分界线
        self.addSubview(self.lineView)
        
        //箭头
        arrowIV.frame = CGRect(x: viewW - 20 - size.width, y: (viewH - size.height)/2, width: size.width, height: size.height)
        arrowIV.image = UIImage.init(named: arrow ?? "")
        self.addSubview(arrowIV)
  
    }
}



extension EntryView{
   //点击事件
    @objc func HitEntryViewEvent(){
        self.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline:.now() + 1) {
            self.isUserInteractionEnabled = true
        }
        if self.hitEntryViewClose != nil {
            self.hitEntryViewClose!()
        }
    }
    //开关事件
    @objc func valueChanged(mySwitch:UISwitch){
        let status:Bool = mySwitch.isOn
        if self.MySwitchClose != nil {
            self.MySwitchClose(status)
        }
        
    }
    
    //获取文本的宽度
    func obtainTextWidth(text:String,font : UIFont = UIFont.systemFont(ofSize: 17)) -> CGFloat {
        let size = CGSize(width:CGFloat.greatestFiniteMagnitude, height:0)
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context:nil)
        return rect.size.width
    }
  
}







































