//
//  JHWebViewController.swift
//  SwiftTool
//
//  Created by yunna on 2018/1/9.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit
import WebKit
class JHWebViewController:  UIViewController,WKNavigationDelegate,WKUIDelegate {
    
    /// 加载url
    var WebURL:String = ""
    
    ///webView
    private lazy var webView:WKWebView = {
        ///创建webView
        var web = WKWebView.init(frame: self.view.bounds)
        web.navigationDelegate = self
        web.uiDelegate = self
        self.view.addSubview(web)
        
        return web
    }()
    ///进度条
    private lazy var processView: UIProgressView = {
        let PV = UIProgressView.init(frame: CGRect(x: 0, y: Double(JHStatusBarAndNavigationBarHeight+1), width: Double(JHScreenWidth), height: 1))
        PV.tintColor = UIColor.orange
        PV.trackTintColor = UIColor.white
        self.view.addSubview(PV)
        
        return PV
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.processView.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        //加载url
        let url = NSURL.init(string: WebURL)
        let request = URLRequest(url: url! as URL)
        self.webView.load(request as URLRequest)

        //添加进度的监听
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)

    }
 
    //移除监听
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}


//MARK: -- webview的d代理方法
extension JHWebViewController {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let process = webView.estimatedProgress
        processView.setProgress(Float(process), animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hidenProcessView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hidenProcessView()
    }
}

extension JHWebViewController {
   
    //添加监听者
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let process:Float = Float(self.webView.estimatedProgress)
            self.processView.setProgress(process, animated: true)
        }
    }
    
    
    ///隐藏进度条
    func hidenProcessView() {
        self.processView.setProgress(1.0, animated: true)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options:.curveEaseIn, animations: {
            self.processView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.4)
        }) { (finished) in
            self.processView.isHidden = true
        }
    }
}









