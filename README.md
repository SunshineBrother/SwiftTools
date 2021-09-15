# Swift学习

  
 - [知识点](https://github.com/SunshineBrother/SwiftTools/blob/master/知识点.md)
- [小工具](https://github.com/SunshineBrother/SwiftTools/blob/master/tools.md)

# 新项目

## 第三方库

- 代码规范
  - 代码规范：[SwiftLint](https://github.com/realm/SwiftLint)
  - 格式化代码：[SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
- 网络
  - 网络请求：Moya+RXSwift+ObjectMapper 
    - json转model：ObjectMapper、HandyJSON、KakaJSON 
    - 快速的格式化JSON数据并转换生成对应的模型类属性：[JSONConverter](https://github.com/DevYao/JSONConverter)
    - json数据处理：[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
  - 网络图片：[Kingfisher](https://github.com/onevcat/Kingfisher)
  - [Reachability.swift](https://github.com/ashleymills/Reachability.swift) - 用于替换苹果的 Reachability 类，可以方便地检测当前是否联网以及具体的联网状态.
- UI
  - 布局：[SnapKit](https://github.com/SnapKit/SnapKit)
  - 刷新：[MJRefresh](https://github.com/CoderMJLee/MJRefresh)
  - 加载框：[MBProgressHUD](https://github.com/jdg/MBProgressHUD)
  - 富文本：[ActiveLabel.swift](https://github.com/optonaut/ActiveLabel.swift)
  - 键盘：[IQKeyboardManager](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fhackiftekhar%2FIQKeyboardManager)
  - 动画：[lottie-ios](https://github.com/airbnb/lottie-ios)
  - 空页面：[DZNEmptyDataSet](https://link.zhihu.com/?target=https%3A//github.com/dzenbot/DZNEmptyDataSet)
- 数据存储
  - 小数据：[SwiftyUserDefaults](https://github.com/sunshinejr/SwiftyUserDefaults)
  - 数据库：
    - [WCDB](https://github.com/Tencent/wcdb)
    - [GRDB.swift](https://github.com/groue/GRDB.swift)
    - [SQLite.swift](https://github.com/stephencelis/SQLite.swift)
- 资源管理
  - [R.swift](https://github.com/mac-cain13/R.swift)：优雅安全的方式使用资源文件
- 安全
  - [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)
- 工具
  - [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift)
- 日志
  - [Logan](https://github.com/Meituan-Dianping/Logan)：美团的大前端日志库
- 埋点
  - [神策](https://manual.sensorsdata.cn/sa/latest/page-1573910.html)
- 组件化
  - [CTMediator](https://github.com/casatwy/CTMediator)
  - [ BeeHive](https://github.com/alibaba/BeeHive)
  



## 需要注意的问题

- 国际化问题
- 路由管理
- 是否有节假日换皮肤的需求
- 黑暗模式是否是配
- tabbar和navigationbar问题 （是否用，待考虑）
  - [ESTabBarController](https://github.com/eggswift/ESTabBarController)
  - [RTRootNavigationController](https://github.com/rickytan/RTRootNavigationController)
- 资源管理
  - 文字（大小，类型）资源：统一格式，json读取
  - color资源：统一格式，json读取
  - 图片资源
- 架构模式（MVC）
  - Model层：api+server+json转model
  - view层：view层仅仅负责布局，事件处理可以通过代理交给controller层处理
  - controller
    - 给view赋值
    - 处理响应事件
    - 处理一些业务逻辑



## 架构

### 基础模块

- 1、tabbarModules(待考虑)

- 2、navigationBarModules(待考虑)

- 3、WrappersModules 包装整个项目

- 4、DataCenterModules 数据中心

- 5、FoundationModules 基于系统库封装

- 6、widgetModules 一些小组建的封装

- 7、sdkModules 

  

### 业务模块

- 1、LoginModule

- 2、HomeModule

- 3、OrderModule

- 4、PayModule

- 5、AnalyseModule埋点

- 6、WebViewModule等等









