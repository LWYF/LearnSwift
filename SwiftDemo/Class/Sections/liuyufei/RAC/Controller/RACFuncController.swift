//
//  RACFuncController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result
import SnapKit

class RACFuncController: UIViewController {

    var textField: UITextField!
    
    fileprivate let textField_top_margin:CGFloat = 20
    fileprivate let textField_height:CGFloat = 100
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "RACFunc"
        self.navigationController?.navigationBar.isTranslucent = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textField = UITextField.init()
        textField.backgroundColor = UIColor.red
        textField.text = ""
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN)
            make.right.equalTo(-MARGIN)
            make.top.equalTo(textField_top_margin + NAVIGATIONBARHEIGHT)
            make.height.equalTo(textField_height)
        }
        // Do any additional setup after loading the view.
    }
    //MARK: 信号
    public func racSignal() {
        //创建信号(冷信号)
        let producer = SignalProducer<String, NoError>.init { (observer, _) in
            YFLog("新的订阅，启动操作")
            observer.send(value: "😆")
        }
        
        let subscriber = Observer<String, NoError>(value: {YFLog("\($0)")})
        producer.start(subscriber)
    }
    //MARK: 监听
    public func racObserver() {
        textField.reactive.continuousTextValues.observeValues { text in
            YFLog(text ?? "")
        }
        
        //监听粘贴进来的文本
        let result = textField.reactive.producer(forKeyPath: "text")
        result.start { (text) in
            YFLog("copy is \(text)")
        }
    }
    //MARK: 存根
    public func racDisposable() {
        
    }
    //MARK: 事件
    public func racEvent() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
