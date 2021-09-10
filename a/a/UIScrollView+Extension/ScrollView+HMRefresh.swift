//
//  UIScrollView.swift
//  a
//
//  Created by HM on 2021/9/9.
//


import UIKit
import MJRefresh
extension UIScrollView {

    /// 添加刷新事件
    ///
    /// - Parameters:
    ///   - refreshHeaderClosure: 头部刷新
    ///   - refreshFooterClosure: 底部刷新
    public func addRefresh(refreshHeaderClosure: @escaping() -> Void,
                           refreshFooterClosure: @escaping() -> Void) {
        
        /// 头部刷新
        let header: MJRefreshNormalHeader = MJRefreshNormalHeader.init {
           refreshHeaderClosure()
        }
        
        // 自动改变透明度 （当控件被导航条挡住后不显示）
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel?.isHidden = true
        // 设置字体
        header.stateLabel?.font = UIFont.systemFont(ofSize: 13)
        header.lastUpdatedTimeLabel?.font = UIFont.systemFont(ofSize: 13)
        header.setTitle("", for: .idle)
        header.setTitle("", for: .pulling)
        header.setTitle("", for: .willRefresh)
        header.setTitle("loading", for: .refreshing)
       
        self.mj_header = header
        
        /// 尾部刷新
        let foot: MJRefreshBackNormalFooter = MJRefreshBackNormalFooter.init {
            refreshFooterClosure()
        }
        
        foot.stateLabel?.font = UIFont.systemFont(ofSize: 13)
        foot.setTitle("", for: .idle)
        foot.setTitle("loading", for: .refreshing)
        foot.setTitle("", for: .pulling)
        foot.setTitle("", for: .idle)
        
        foot.setTitle("暂无数据", for: MJRefreshState.noMoreData)
        foot.ignoredScrollViewContentInsetBottom = getTabbarSafeBottomMargin()
        self.mj_footer = foot
        
    }
    
    
    /// 添加头部刷新事件
    ///
    /// - Parameter refreshClosure: 闭包回调
    public func addHeaderRefresh(refreshClosure: @escaping() -> Void) {
        
        let header: MJRefreshNormalHeader = MJRefreshNormalHeader.init {
            refreshClosure()
        }
        
        // 自动改变透明度 （当控件被导航条挡住后不显示）
        header.isAutomaticallyChangeAlpha = true
        // 设置字体
        header.stateLabel?.font = UIFont.systemFont(ofSize: 13)
        header.lastUpdatedTimeLabel?.font = UIFont.systemFont(ofSize: 13)
        self.mj_header = header
    }
    
    /// 下拉加载
    ///
    /// - Parameters:
    ///   - refreshClosure: 闭包回调
    public func addFooterRefresh(refreshClosure:@escaping() -> Void) {
        let foot: MJRefreshBackNormalFooter = MJRefreshBackNormalFooter.init {
            refreshClosure()
        }
        
        foot.stateLabel?.font = UIFont.systemFont(ofSize: 13)
        foot.setTitle("", for: MJRefreshState.idle)
        foot.setTitle("暂无数据", for: MJRefreshState.noMoreData)
        
        self.mj_footer = foot
        
    }
    
    
    /// 结束刷新
    ///
    /// - Parameter tableView: tableView
    public func endRefresh() {
       
        if self.mj_header != nil {
            self.mj_header?.endRefreshing()
        }
        if self.mj_footer != nil {
            self.mj_footer?.endRefreshing()
        }
        
    }
    
    
    /// 没有数据
    public func noMoreData() {
        guard self.mj_footer != nil else {
            return
        }
        self.mj_footer?.state = .noMoreData
    }
    
    
    /// 底部安全距离
    private
    func getTabbarSafeBottomMargin() -> CGFloat {
        var safeBottom: CGFloat = 0
        if #available(iOS 11, *) {
            let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
            safeBottom = safeArea?.bottom ?? 0
        }
        return safeBottom
    }

}


















