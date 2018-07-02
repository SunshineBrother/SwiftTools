//
//  Refresh.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/3.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import MJRefresh
extension UIScrollView {

    /// 添加刷新事件
    ///
    /// - Parameters:
    ///   - refreshHeaderClosure: 头部刷新
    ///   - refreshFooterClosure: 底部刷新
    func addRefreshWithScrollView(refreshHeaderClosure:@escaping()->(), refreshFooterClosure:@escaping()->())  {
        
        ///*******头部刷新*************
        let header:MJRefreshNormalHeader = MJRefreshNormalHeader.init {
           refreshHeaderClosure()
        }
        
        //自动改变透明度 （当控件被导航条挡住后不显示）
        header.isAutomaticallyChangeAlpha = true
        // 设置字体
        header.stateLabel.font = UIFont.systemFont(ofSize: 13)
        header.lastUpdatedTimeLabel.font = UIFont.systemFont(ofSize: 13)
        self.mj_header = header
        
        ///**********尾部刷新**********
        let foot:MJRefreshBackNormalFooter = MJRefreshBackNormalFooter.init {
            refreshFooterClosure()
        }
        
        foot.stateLabel.font = UIFont.systemFont(ofSize: 13)
        foot.setTitle("", for: MJRefreshState.idle)
        foot.setTitle("暂无更多数据", for: MJRefreshState.noMoreData)
 
        self.mj_footer = foot
        
    }
    
    
    /// 添加头部刷新事件
    ///
    /// - Parameter refreshClosure: 闭包回调
    func addRefreshHeaderWithScrollView(refreshClosure:@escaping()->()) {
        
        let header:MJRefreshNormalHeader = MJRefreshNormalHeader.init {
            refreshClosure()
            }  
        
        //自动改变透明度 （当控件被导航条挡住后不显示）
        header.isAutomaticallyChangeAlpha = true
        // 设置字体
        header.stateLabel.font = UIFont.systemFont(ofSize: 13)
        header.lastUpdatedTimeLabel.font = UIFont.systemFont(ofSize: 13)
        self.mj_header = header
    }
    
    /// 下拉加载
    ///
    /// - Parameters:
    ///   -  tableView: tableView
    ///   - refreshClosure: 闭包回调
    func addRefreshFooterWithScrollView(refreshClosure:@escaping()->()) {
        let foot:MJRefreshBackNormalFooter = MJRefreshBackNormalFooter.init {
            refreshClosure()
        }
        
        foot.stateLabel.font = UIFont.systemFont(ofSize: 13)
        foot.setTitle("", for: MJRefreshState.idle)
        foot.setTitle("暂无更多数据", for: MJRefreshState.noMoreData)
        
        self.mj_footer = foot
        
    }
    
    
    /// 结束刷新
    ///
    /// - Parameter tableView: tableView
    func endRefreshWithTableView() {
       
        if (self.mj_header != nil) {
            self.mj_header.endRefreshing()
        }
        if (self.mj_footer != nil) {
            self.mj_footer.endRefreshing()
        }
        
    }
    
    
    /// 没有数据
    func NOMoreData() {
        self.mj_footer.state = .noMoreData
    }
    
}


















