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
- 健康分享权限：Privacy - Health Share Usage Description
- 健康更新权限：Privacy - Health Update Usage Description
- 运动使用权限：Privacy - Motion Usage Description
- 音乐权限：Privacy - Music Usage Description
- 提醒使用权限：Privacy - Reminders Usage Description
- Siri使用权限：Privacy - Siri Usage Description
- 电视供应商使用权限：Privacy - TV Provider Usage Description
- 视频用户账号使用权限：Privacy - Video Subscriber Account Usage Description
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

























































