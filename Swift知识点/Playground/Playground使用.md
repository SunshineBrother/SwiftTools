 
# Playground 使用


Playground是一个强大的工具。对于Swift初学者来说，它简单易用，可以实时预览代码效果，非常适合学习Swift这门语言。在日常开发中，playground可以进行快速的原型开发和试错。当然，playground支持markup标注，用来Swift相关的书籍也不错。


- 在 iOS / MacOS 的playground中, 我们可以导入对应系统支持的库文件, 还可以导入这种 Playground 独有的框架, 比如  PlaygroundSupport , 用于界面可视化.
- Playground 支持 MarkUp 语法, 这是一种类似 Markdown 的语法.
- 我们可以在playground 编写任何符合 iOS / MacOS 的代码, 包括各种动画, 游戏等.


### 文件区


当我们创建完一个 playground 后, 会自动创建一个 Page , 这个 Page 里包含两个文件, 如果文件夹是空的, 图标是暗色的.

- Sources: 存放当前 Playground Page 的代码.
- Resources: 资源文件, 包括图片, 文件等资源.

如果我们想创建多个 Playground Page, 在Xcode菜单栏, File -> New -> Playground Page, 就会创建一个新的 Page. 在运行代码时, 每个 Page 是分开的.



出现文件区的命令:`commond + 1`


### 代码编辑区

**简单使用**

创建了一个红色视图

```
import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.backgroundColor = UIColor.red
PlaygroundPage.current.liveView = view
```


**使用一些资源**


把图片放到`Resources`文件夹中

```
let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
iv.image = UIImage(named: "logo")
PlaygroundPage.current.liveView = iv
```


**引入其他文件**

我们在Source文件夹中，新建（command + N）一个RandomColorView.swift

Playground的Source文件如果要暴露给其他Module，需要声明为public。

```
let bg = RandomColorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
PlaygroundPage.current.liveView = bg

```


```
import UIKit
public class RandomColorView : UIView{
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
 
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        self.backgroundColor = UIColor.red
        
    }
    
    @objc
    func handleTap(){
         print("点击RandomColorView")
    }
    
}
```

### 注释


Playground的注释支持markup语法

开启markup渲染效果：Editor -> Show Rendered Markup

注意：Markup只在Playground中有效



```
// 单行注释

/*
 多行注释
 /*
 多行注释
 */
 
 markup语法
 ## 二级标题
 ### 三级标题
 */


//: # 一级标题

/*:
 # 学习Swift
 ## 基础语法
 - 变量
 - 常量
 ## 面向对象
 1. 类
 2. 属性
 3. 方法
 ## 汇编分析
 
 [苹果官方](https://www.apple.com)
 */

//: [下一页](@next)
//: [上一页](@previous)

```










































