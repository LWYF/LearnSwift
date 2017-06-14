//
//  RACController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result


class RACController: UIViewController {
    
    lazy var racModel = {
        return RACViewModel()
    }()
    
    var table: RACTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table = RACTableView.init(frame: view.bounds, style: .plain)
        view.addSubview(table)
        
        racModel.loadAsyncCompleted(succeed: { (success) in
            //隐式解析,不建议强制解析
            if let model = success {
                self.table.models = model as? [RACModel]
            }
        }) { (error) in
            YFLog(error)
        }
        
        click()
    }
    
    func click() {
        table.signal.observeValues { (racType) in
            let clickType:RACType = RACType(rawValue: racType as! String)!
            let controller = RACFuncController()
            switch clickType {
            case .signal:
                controller.racSignal()
                break
            case .event:
                controller.racEvent()
                break
            case .observer:
                controller.racObserver()
                break
            case .disposable:
                controller.racDisposable()
                break
            default:
                break
            }
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
