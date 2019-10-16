***文章持续更新中，欢迎star和issues***


![UITextField](https://github.com/SunshineBrother/SwiftTools/blob/master/GIF/UITextField.gif)
![UITextView](https://github.com/SunshineBrother/SwiftTools/blob/master/GIF/UITextView.gif)
![UILabel扩展](https://github.com/SunshineBrother/SwiftTools/blob/master/GIF/UILabel扩展.gif)
![倒计时](https://github.com/SunshineBrother/SwiftTools/blob/master/GIF/倒计时.gif)
![下拉列表](https://github.com/SunshineBrother/SwiftTools/blob/master/GIF/下拉列表.gif)
![UIButton扩展](https://github.com/SunshineBrother/SwiftTools/blob/master/GIF/UIButton扩展.png)
![entry](https://github.com/SunshineBrother/SwiftTools/blob/master/GIF/entry.png)
# SwiftTools
技术不够，努力来凑；封装不了一个伟大的开源框架，但是仍然想要有一个自己的开源项目，所以就准备把一些项目中的常用工具类给封装出来，省的每一次写项目的时候都要重写一遍。
 
 
 ## UIKit
 
 ### UITextField
 ##### 方法
 |名称|说明|
 |---|:---:|
 |setPlaceHolderTextColor(_ color: UIColor)|设置placehold颜色|
 |distanceSides(_ leftWidth:CGFloat,_ rightWidth:CGFloat? = 0)|文本距离左右侧的距离|
 |addLeftIcon(_ image: UIImage,size:CGSize,padding: CGFloat)| 添加左侧icon|
 |addRightIcon(_ image: UIImage,size:CGSize,padding: CGFloat)|添加右侧icon|
|addLeftTile(titleLabel:UILabel,titleWidth:CGFloat,padding: CGFloat)|添加左侧标题|
 
 #### 属性
 |名称|说明|
 |---|:---:|
 |maxCount|最大数量|
|moneyType|输入金额类型|
|MobileType|手机号类型 手机号类型 普通的12345678901   344格式 123 4567 8901|

  ### UITextView
  #### 属性
  |名称|说明|
  |---|:---:|
  |tapTwiceDisapper| 点击两下键盘消失|
  |MaxCount|最大允许输入文本输入量|
  |placeHolder|设置placeHolder|
  |placeHolder|设置placeHolder的颜色|
 
 
### UIView

#### 计算属性
|名称|说明|
|---|:---:|
|ViewID|String|
|ViewParam|Dictionary<String, Any>?|

#### 存储属性
|名称|说明|
|---|:---:|
|W|宽|
|H|高|
|X|X|
|Y|Y|
|centerX|centerX|
|centerY|centerY|
 
#### 方法
|名称|说明|
|---|:---:|
|removeAllChildView|移除所有子视图|
|public func addCornerRadius(radius: CGFloat) {}|设置圆角|
| public func addBorder(width: CGFloat, color: UIColor) {}|设置边框|
|public func addBorderTop(size: CGFloat, color: UIColor) {}|设置顶部边框|
|public func addBorderBottom(size: CGFloat, color: UIColor) {}|设置底部边框|
|public func addBorderLeft(size: CGFloat, color: UIColor) {}|设置左侧边框|
|public func addBorderRight(size: CGFloat, color: UIColor) {}|设置右侧边框|
|public func toImage () -> UIImage {}|view截图为image|
 

### UILabel扩展
|名称|说明|
|---|:---:|
|WordSpace|字间距|
|LineSpace|行间距|
|topText|是否让文本居左上|
|isCopyable|是否拥有复制功能|

 ### UIButton扩展
 |名称|说明|
 |---|:---:|
 |func setTitleColor(normolColor:UIColor,selectColor:UIColor)  {}|设置选中状态文字颜色|
 |func setImage(normolImge:UIImage,selectImage:UIImage)  {}|设置选择状态和未选中状态的image|
 |func setTitleWithTitleColor(title:String,titleColor:UIColor)  {}|设置未选择状态的title和col|
 |func setTitleWithImage(title:String,image:UIImage) {}|设置title&image|
 |timeInterval|连续两次点击相差时间|
 |topEdge,leftEdge,rightEdge,bottomEdge|点击区域|
 |func setEnlargeEdge(top:CGFloat,right:CGFloat,bottom:CGFloat,left:CGFloat)  {}|扩大点击区域|
 |func setImageFrontTextWithCenterAlignment(imageWidth:CGFloat, space:CGFloat)  {}|整体在中间 image在左 title在右|
 |func setImageFrontTextWithLeftAlignment(imageWidth:CGFloat, space:CGFloat,buttonWidth : CGFloat)  {}|整体在最左侧   image在左 title在右|
 |func setImageFrontTextWithTopAlignment(imageWidth:CGFloat, space:CGFloat)  {}|上下结构 image在上 label在下|
 
 ### UIAlertController扩展
 |名称|说明|
 |---|:---:|
 |showSystemPOPView(title:String? = "提示",message:String,titleArr:[String],type:SystemPOPType,complete:@escaping ((NSInteger)->(Void))) {}|弹出系统提示框|
 
 这里仅仅对系统弹框做了一个简单的封装，如果想要其他的弹框，网上有很多的
 ```
 JHPOPAlertView.showSystemPOPView(message: "我是测试", titleArr: ["取消","确定"], type: .alert) { (index) -> (Void) in
 
 }
 ```
 ### UITapGestureRecognizer扩展
 |名称|说明|
 |---|:---:|
 |timeInterval|两次点击相差的时间|
 |init(target: Any?, action: Selector?,timeInterval:CGFloat) {}|初始化|

 
## UIFoundation
### String扩展
#### 属性
|名称|说明|
|---|:---:|
|urlEncoded|URL编码|
|urlDecode|URL解码|
|base64|base64编码|
|base64Decode|Base64解码|
|isEmail|是否是邮箱|
|isValidUrl|是否是URL|
|isMobile|是否是手机号|
|isAlphanumeric|是否是字母数字的组合|
 
 ##### 方法
 |名称|说明|
 |---|:---:|
 |subStringFrom(index: Int,length:Int) -> String|字符串的截取|
 |substring(from: Int, to: Int) -> String|字符串的截取|
 |substring(from: Int?, to: Int?) -> String|字符串的截取|
 |substring(from: Int) -> String|字符串的截取|
 |substring(to: Int) -> String|字符串的截取|
 |stringByReplacingCharactersInRange(index:Int,length:Int,replacText:String) -> String |替换指定范围内的字符串|
 |stringByReplacingstringByReplacingString(text:String,replacText:String) -> String|替换指定字符串|
 |deleteEndCharacters() -> String|删除最后一个字符|
 |deleteString(string:String) -> String |删除指定字符串|
 |split(string:String) -> [String]|将字符串通过特定的字符串拆分为字符串数组|
 |toInt() -> Int?|变成Int 类型|
 |toDouble() -> Double?|变成Double 类型|
 |toFloat() -> Float?|变成Float 类型|
 |obtainTextHeight(font : UIFont = UIFont.systemFont(ofSize: 18), fixedWidth : CGFloat) -> CGFloat|获取文本高度|
 |obtainTextWidth(font : UIFont = UIFont.systemFont(ofSize: 17)) -> CGFloat|获取文本宽度|
 |func insertString(text:Character,index:Int) -> String{}|字符的插入|
 | func insertString(text:String,index:Int) -> String{}|字符串的插入|
### Array扩展
|名称|说明|
|---|:---:|
|removedDuplicates|删除  重复元素|

### Dictionary扩展
|名称|说明|
|---|:---:|
|addDictionary|拼接字典|
|has(key: Key) -> Bool|判断是否存在|
| removeAll(keys: [Key])|删除所有|
|jsonString(prettify: Bool = false) -> String?|Json字典转Json字符串|
|jsonData(prettify: Bool = false) -> Data?|Json字典转Data|
 
 ### 值类型转换
 |名称|说明|
 |---|:---:|
 |class func data(from jsonString:String) -> Data {}|把字符串转变为data|
 |class func jsonString(from data:Data) -> String {}|data 转 字符串|
 |class func jsonString(from dictionary:Dictionary<String, Any>) -> String {}|字典转换为JSONString|
 | class func dictionary(from jsonString:String) -> Dictionary<String, Any> {}|JSONString转换为字典|
 | class func data(from jsonDic:Dictionary<String, Any>) -> Data {}|字典转二进制|
 |class func dictionary(from data:Data) -> Dictionary<String, Any> {}|二进制转字典|
 |class func data(from array:Array<Any>) -> Data {}|数组转data|
 |class func array(from data:Data) -> Array<Any> {}|data转数组|
 
  ### Date扩展
  #### 存储属性
  |名称|说明|
  |---|:---:|
  |CurrentStingTime|获取当前时间字符串|
  |CurrentDateTime|获取当前时间 date|
  |CurrentStampTime|获取当前时间戳|
  |year|年|
  |month|月|
  |day|日|
  |weekday|周几|
  |isFuture|是否在将来|
  |isPast|是否在过去|
  |isToday|是否是今天|
  |isTomorrow|是否是昨天|
  
#### 方法
|名称|说明|
|---|:---:|
|func StampTime(from date:Date) ->  u_long{}|date 转化为时间戳|
|func date(from StampTime:u_long) -> Date {}|时间戳转化为date|
 
    
### 正则表达式
|名称|说明|
|---|:---:|
|func EmailIsValidated(vStr: String) -> Bool {}|验证邮箱|
|func PhoneNumberIsValidated(vStr: String) -> Bool {}|验证手机号|
|func NumberIsValidated(vStr: String) -> Bool {}|验证只能输入数字|
|func SpecificNumbersIsValidated(vStr: String) -> Bool {}|验证输入几位数字|
|func ChineseIsValidated(vStr: String) -> Bool {}|验证是否是中文|
|func IllegalCharacterIsValidated(vStr: String) -> Bool {}|验证是否含有^%&',;=?$\"等字符|
|func URLIsValidated(vStr: String) -> Bool {}|验证URL|
|func QQIsValidated(vStr: String) -> Bool {}|验证QQ号|
|func IdCardIsValidated(vStr: String) -> Bool {}|验证身份证号|
 
 
 ### 颜色扩展
 |名称|说明|
 |---|:---:|
 |random|随机色|
 |RGBA|RGBA|
 |rgb|rgb|
 |hex|UIColor转化为16进制|
 
 
 
 ## UIFoundation
 ### MBProgressHUD封装
 这里就有三个简单的方法

 |名称|说明|
 |---|:---:|
 |class func ShowMessage(text:String,touch:Bool? = false,afterDelay:TimeInterval? = 1.0) {}|提示文本|
 |class func ShowloadingWithMessage(text:String?,touch:Bool? = false) {}|加载框|
 |class func dismissHUD()  {}|隐藏 加载框|
 
  ### MJRefresh封装
  我这里对MJRefresh进行了封装，其实是对UIScrollView的扩展，我们在使用的时候不需要一遍一遍的创建，只需要调用一个方法就可以了
  ```
  self.tableView.addRefreshWithScrollView(refreshHeaderClosure: {
  //头部刷新
  }) {
  //底部刷新
  }
  ```
  |名称|说明|
  |---|:---:|
  |func addRefreshWithScrollView(refreshHeaderClosure:@escaping()->(), refreshFooterClosure:@escaping()->())  {}|添加刷新事件|
  |func addRefreshHeaderWithScrollView(refreshClosure:@escaping()->()) {}|添加头部刷新事件|
  |func addRefreshFooterWithScrollView(refreshClosure:@escaping()->()) {}|添加底部刷新事件|
  |func endRefreshWithTableView() {}|结束刷新|
  |func NOMoreData() {}|没有数据|
  

### DZNEmptyDataSet封装

|名称|说明|
|---|:---:|
|func addEmpty(text:String? = nil,image:String? = nil,offSet:CGFloat? = 0)|可选文本，image，offset|
|func addEmpty(text:String,image:String,offSet:CGFloat)|文本，image，offset|
|func addEmpty(text:String,image:String)|文本，image|
|func addEmpty(image:String)|image|
|func addEmpty(text:String)|文本|
|obtainClickClosure|点击闭包回调|
    
这个封装使用起来也是非常的简单
```
//空白数据的时候
self.tableView.addEmpty(text: "空白数据", image: "Head", offSet: 0)
self.tableView.obtainClickClosure {
//点击空白的回调
print("点击空白的回调")
}
```
    
## 杂类
   
###  LocationTool

一行代码获取用户的经纬度以及地理信息，再也不用写上百行代码来实现这个简单的功能了

|名称|说明|
|---|:---:|
|func getUserCoordinate(_ coordinateCallBack: @escaping (_ coordinate : CLLocationCoordinate2D?) -> (), _ addressCallBack:@escaping (_ Placemark : CLPlacemark?) -> ()) {}||
```
LocationTool.sharedInstance.getUserCoordinate({ (coor) in
print(coor)
}) { (place) in
print(place)
}
```
###  倒计时
这里直接继承自button，写法完全是跟button一样
```
let btn = TimerButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
btn.backgroundColor = UIColor.gray
btn.setUP(start: "点击获取验证码", prefix: "倒计时", countTime: 10) {
btn.isWorking = true
print("*************")

} 
self.view.addSubview(btn)
```
###  小条目
我们在写一些小条目的时候有的时候会感觉很厌烦，然后我就简单的总结了几个类型

|名称|说明|
|---|:---:|
|hitEntryViewClose|添加点击事件回调|
|SetUpTitle(mainTitle:,subtitle:)|主标题&副标题|
|SetUpTitle(mainTitle:,subtitle:,arrow:,size:)|主标题&副标题&箭头|
|SetUpTitle(mainTitle:,arrow:,size:)|主标题*&箭头|
|SetUPSwitch(mainTitle:,switchOn:,SwitchClose:）|主标题&开关按钮|
|SetUPTextField(mainTitle:,placeHolder:)|主标题&UITextfield|
|SetUPTextField(mainTitle:,placeHolder:,arrow:,size:)|主标题&UITextfield&箭头|
|SetUPSubtitleIV(mainTitle:,SubtitleIcon:,SubtitleSize:,arrow:,size)|主标题，右侧图片，箭头|
|SetUPMainIV(mainIcon:,mainSize:,mainTitle:,spacing:,arrow:,size:)|左侧图片，标题|

### 下拉列表
```
//设置属性
popMenuList.append((icon: "", title: "测试1"))
popMenuList.append((icon: "", title: "测试2"))
popMenuList.append((icon: "", title: "测试3"))
popMenuList.append((icon: "", title: "测试4"))

self.popMenu = SwiftPopMenu(frame: CGRect(x: 130, y: 210, width: 80, height: 200))
self.popMenu.popData = popMenuList
//点击菜单
self.popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
self?.popMenu.dismiss()

}
self.popMenu.show()
```


 
 ## 硬件
 关于硬件方面我分了一下几个方面
 - 1、各种权限获取，以及跳转的相应设置
 - 2、获取设备的一些信息
 - 3、判断手机上是否安装了某些应用
 - 4、开启一些设备
 
 ### 权限管理
 我们知道现在苹果越来越重视用户隐私了，几乎所有的涉及到用户的都需要我们进行权限申请
 这里我封装了一下几个功能
 - 1、各种权限判断，判断我们是否拥有权限
 - 2、跳转到相应地方开启权限
 

我们在进行权限判定的时候，可以调用这个方法
```
func isAllowService(type:LimitService_Type) -> Bool {}
```
 我们在开启设备的跳转的时候
 ```
 func TurnOnServeManager() {}
 ```
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

























































