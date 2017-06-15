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
    
    fileprivate let rac_tableView_height:CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let frame = CGRect(x: 0, y: NAVIGATIONBARHEIGHT, width: SCREEN_WIDTH, height: rac_tableView_height)
        table = RACTableView.init(frame: frame, style: .plain)
        view.addSubview(table)
        
        
        let tips = UILabel()
        tips.frame = CGRect(x: MARGIN, y: rac_tableView_height + NAVIGATIONBARHEIGHT + MARGIN, width: SCREEN_WIDTH - 2 * MARGIN, height: rac_tableView_height)
        tips.text = "RAC：数据与视图绑定，当数据变化时，视图不需要额外的处理，便可正确的呈现最新的数据\n"
        tips.numberOfLines = 0
        tips.sizeToFit()
        view.addSubview(tips)
        
        
        racModel.loadAsyncCompleted(succeed: { (success) in
            //隐式解析,不建议强制解析
            if let model = success {
                self.table.models = model as? [RACModel]
            }
        }) { (error) in
            YFLog(error)
        }
        //监听点击事件，只要有点击就执行
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
