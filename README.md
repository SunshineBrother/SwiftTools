***文章持续更新中，欢迎star和issues***


![UITextField](https://github.com/SunshineBrother/SwiftTools/blob/master/GIF/UITextField.gif)
![UITextView](https://github.com/SunshineBrother/SwiftTools/blob/master/GIF/UITextView.gif)



# SwiftTools
技术不够，努力来凑；封装不了一个伟大的开源框架，但是仍然想要有一个自己的开源项目，所以就准备把一些项目中的常用工具类给封装出来，省的每一次写项目的时候都要重写一遍。


 
 
 ## UIKit
 
 ### UITextField
 对于UITextField我主要扩展了一下内容
 - 设置placeHolder的颜色
 - 设置左侧图标，右侧图标
 - 设置文本输入与左侧的距离
 - 一些类型的限制
    - 1、输入手机号
           - 1、不做任何限制
           - 2、输入格式344
    - 2、输入金额
    - 3、位数的限制
 

 
 ***我一共封装了5个方法，3个属性***
 
 #### 5个方法
 ```
 ///设置placehold颜色
 func setPlaceHolderTextColor(_ color: UIColor) {}
 ///文本距离左右侧的距离
 func distanceSides(_ leftWidth:CGFloat,_ rightWidth:CGFloat? = 0)  {}
 /// 添加左侧icon
 func addLeftIcon(_ image: UIImage,size:CGSize,padding: CGFloat)  {}
 /// 添加右侧icon
 func addRightIcon(_ image: UIImage,size:CGSize,padding: CGFloat)  {}
 /// 添加左侧标题
 func addLeftTile(titleLabel:UILabel,titleWidth:CGFloat,padding: CGFloat)  {}

 ```
  #### 3个属性
- maxCount 最大数量
- moneyType 输入金额类型
- MobileType 手机号类型 
手机号类型 普通的12345678901   344格式 123 4567 8901
//手机号类型
enum MobilePhoneType: String {
case MobileCommon = "MobileCommon"
case MobileSpecial = "MobileSpecial"
}
 
 
  ### UITextView
  我在自定义的`JHTextView`中添加了4个常用属性
  - 1、tapTwiceDisapper 点击两下键盘消失
  - 2、MaxCount。 最大允许输入文本输入量
  - 3、设置placeHolder
  - 4、设置placeHolder的颜色
 
 
 
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
/// 权限服务
///
/// - Parameter type: 类型
/// - Returns: 返回结果
func isAllowService(type:LimitService_Type) -> Bool {}
```
 我们在开启设备的跳转的时候
 ```
 func TurnOnServeManager() {}
 ```
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

























































