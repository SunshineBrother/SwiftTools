//
//  ViewController.swift
//  a
//
//  Created by 姜军辉 on 2021/9/7.
//

import UIKit
import RxSwift
class ViewController: UIViewController {
    public let server = HttpServer.share
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
//        server.getGoods().subscribe { event in
//            switch event {
//            case .next(let model):
//                print(model.specialColumnList.count)
//            case .error(let error):
//                print(error)
//            case .completed:
//                break
//            }
//
//        }.disposed(by: disposeBag)
//
        server.getsys().subscribe { event in
            switch event {
            case .next(let model):
                print(model.code)
            case .error(let error):
                print(error)
            case .completed:
                break
            }
            
        }.disposed(by: disposeBag)
        
    }

    
}

