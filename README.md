# SwiftTools
技术不够，努力来凑；封装不了一个伟大的开源框架，但是仍然想要有一个自己的开源项目，所以就准备把一些项目中的常用工具类给封装出来，省的每一次写项目的时候都要重写一遍

## git常见命令
 
 - `git pull`拉去远程文件
 - `git push`提交文件到远程
 - `git status`是哪些文件有所修改
 - `git diff` 可以查询所修改的代码
 - `git add -A` 增加自己所做的修改
 
 #### 版本回退
 
 `git log` 查看提交历史
 
 本地分支版本回退`git reset --hard commitID`,  `commitID `就是我们要返回的那个历史提交
 
 `git revert HEAD `              撤销前一次 commit
 
 `git revert HEAD^    `          撤销前前一次 commit
 
 
 
 远程分支版本回退:
 - 1、首先要回退本地分支
 ```
 git log
 git reset --hard commitID
 ```
 - 2、强制推送到远程分支
 ```
 git push -f
 ```
 
 
 #### 创建与合并分支
 `git branch` 查看分支
 `git branch <name>` 创建分支
 `git checkout <name>` 切换分支
 `git checkout -b <name>` 创建+切换分支
 `git merge <name>` 合并某分支到当前分支
 `git branch -d <name>` 删除分支
 
 `git status` 查看冲突情况
 
 
 #### 标签
 `git tag <name>` 用于新建一个标签，默认为HEAD
 对`commit id`打标签`git tag <name> commitId`
 `git tag -a <tagname> -m "blablabla..."`可以指定标签信息
 `git tag`可以查看所有标签。
 `git push origin <tagname>`推送一个本地标签到远程
 `git push origin --tags` 可以推送全部未推送过的本地标签
 `git tag -d <tagname>` 可以删除一个本地标签
 `git push origin :refs/tags/<tagname>`可以删除一个远程标签
 
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
 
textField是我们最常用的一个控件之一了，对于他的一些基本属性根本没有必要介绍了，但是有几个稍微有点特殊的属性我就简单的介绍一下
- 1、leftView，rightView，这两个属性分别能设置textField内的左右两边的视图
 - 2、background，disabledBackground，都是设置背景，一个是UIColor属性，一个是UIImage属性
 - 3、UITextFieldViewMode，这是一个枚举，用来定义ViewMode什么时候显示
   
```
      typedef enum {
         UITextFieldViewModeNever,　重不出现
         UITextFieldViewModeWhileEditing, 编辑时出现
         UITextFieldViewModeUnlessEditing,　除了编辑外都出现
         UITextFieldViewModeAlways 　一直出现
         } UITextFieldViewMode;
 ```
- 4、keyboardType 键盘的样式
 ```
 typedef enum {
 UIKeyboardTypeDefault,     　默认键盘，支持所有字符         
 UIKeyboardTypeASCIICapable,　支持ASCII的默认键盘
 UIKeyboardTypeNumbersAndPunctuation,　标准电话键盘，支持＋＊＃字符
 UIKeyboardTypeURL,            URL键盘，支持.com按钮 只支持URL字符
 UIKeyboardTypeNumberPad,            　数字键盘
 UIKeyboardTypePhonePad,　 　电话键盘
 UIKeyboardTypeNamePhonePad, 　电话键盘，也支持输入人名
 UIKeyboardTypeEmailAddress, 　用于输入电子 邮件地址的键盘     
 UIKeyboardTypeDecimalPad,   　数字键盘 有数字和小数点
 UIKeyboardTypeTwitter,      　优化的键盘，方便输入@、#字符
 UIKeyboardTypeAlphabet = UIKeyboardTypeASCIICapable, 
 } UIKeyboardType;
 ```
 - 5、UITextField派生自UIControl，所以UIControl类中的通知系统在文本字段中也可以使用。除了UIControl类的标准事件，你还可以使用下列UITextField类特有的事件
 ```
 UITextFieldTextDidBeginEditingNotification
 UITextFieldTextDidChangeNotification
 UITextFieldTextDidEndEditingNotification
 当文本字段退出编辑模式时触发。通知的object属性存储了最终文本
 ```
 
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

***权限分类***
升到iOS10之后，需要设置权限的有：
- 麦克风权限：Privacy - Microphone Usage Description 是否允许此App使用你的麦克风？
- 相机权限： Privacy - Camera Usage Description 是否允许此App使用你的相机？
- 相册权限： Privacy - Photo Library Usage Description 是否允许此App访问你的媒体资料库？
- 通讯录权限： Privacy - Contacts Usage Description 是否允许此App访问你的通讯录？
- 蓝牙权限：Privacy - Bluetooth Peripheral Usage Description 是否许允此App使用蓝牙？
- 语音转文字权限：Privacy - Speech Recognition Usage Description 是否允许此App使用语音识别？
- 日历权限：Privacy - Calendars Usage Description
- 定位权限：Privacy - Location When In Use Usage Description
- 定位权限: Privacy - Location Always Usage Description
- 位置权限：Privacy - Location Usage Description
- 媒体库权限：Privacy - Media Library Usage Description

 

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
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

























































