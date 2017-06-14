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
    
    fileprivate let textField_top_margin:CGFloat = 20
    fileprivate let textField_height:CGFloat = 100
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "RACFunc"
        self.navigationController?.navigationBar.isTranslucent = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        racFunc()
        // Do any additional setup after loading the view.
    }
    
    //MARK: RAC的其他方法
    private func racFunc() {
        /*on,通过on来观察signal，生成一个新的信号，即使没有订阅者也会被触发
        和observe相似，也可以只观察你关注的某个事件
         */
        let signal = SignalProducer<String, NoError>.init { (obverse, _) in
            obverse.send(value: "观察")
            obverse.sendCompleted()
        }
        
        //通过on观察signal,生成一个新的信号，即使没有订阅者，也会被触发
        let superier = signal.on(starting: { 
            YFLog("start")
        }, started: { 
            YFLog("end")
        }, event: { (event) in
            YFLog("event:\(event)")
        }, failed: { (error) in
            YFLog("error:\(error)")
        }, completed: { 
            YFLog("信号完成")
        }, interrupted: { 
            YFLog("信号被中断")
        }, terminated: { 
            YFLog("信号结束")
        }, disposed: { 
            YFLog("信号清理")
        }) { (value) in
            YFLog("value is \(value)")
        }
        
        superier.start()
        
        //map,映射，用于将一个事件流的值操作后的结果产生一个新的事件流
        let (signalMap, observer) = Signal<String, NoError>.pipe()
        signalMap.map { (value) -> Int in
            return value.lengthOfBytes(using: .utf8)
        }.observeValues { (length) in
            YFLog("length is \(length)")
        }
        
        observer.send(value: "demo")
        observer.send(value: "something")
        
        //filter，按照之前预设的条件过滤掉不满足的值
        let (signalFilter, observerFilter) = Signal<Int, NoError>.pipe()
        signalFilter.filter { (value) -> Bool in
            return value % 2 == 0
        }.observeValues { (value) in
            YFLog("valueFilter is \(value)")
        }
        observerFilter.send(value: 3)
        observerFilter.send(value: 4)
        //reduce,将事件里的值聚集后组合成一个值
        let (signalReduce, obserReduce) = Signal<Int, NoError>.pipe()
        //reduce后为初始值
        signalReduce.reduce(2) { (a, b) -> Int in
            //a是相乘后的值，b是传入值
            YFLog("a = \(a), b = \(b)")
            return a * b
        }.observeValues { (value) in
            YFLog("reduce is \(value)")
        }
        obserReduce.send(value: 2)
        obserReduce.send(value: 1)
        obserReduce.send(value: 4)
        obserReduce.send(value: 5)
        //最后算出来的值直到输入的流完成后才会被发送出去
        obserReduce.sendCompleted()
        
        
        /*flatten将一个事件流里的事件变成单一的事件流，
         新的事件流的值按照指定的策略由内部的事件流的值组成
        */
        /*merge,按照时间顺序组成，将每个流的值立刻组合输出，
        无论内部还是外层的流如果收到失败就终止
        */
        let (producerA, observerLetter) = Signal<String, NoError>.pipe()
        let (producerB, observerNum) = Signal<String, NoError>.pipe()
        let (signalMerge, observeMerge) = Signal<Signal<String, NoError>,NoError>.pipe()
        signalMerge.flatten(.merge).observeValues { (value) in
            YFLog("merge is \(value)")
        }
        
        observeMerge.send(value: producerA)
        observeMerge.send(value: producerB)
        observeMerge.sendCompleted()
        
        observerLetter.send(value: "a")
        observerLetter.send(value: "b")
        observerNum.send(value: "3")
        observerNum.send(value: "4")
        
        /*
         concat策略是将内部的SignalProduce排序，
         外层的producer是马上被start.随后的producer直到前一个发送完成后才会start,
         一有失败立即传到外层
         */
        let (signalConcat, obserConcat) = Signal<Signal<String, NoError>,NoError>.pipe()
        signalConcat.flatten(.concat).observeValues { (value) in
            YFLog("concat is \(value)")
        }
        
        obserConcat.send(value: producerA)
        obserConcat.send(value: producerB)
        obserConcat.sendCompleted()
        
        observerLetter.send(value: "concat1")
        observerNum.send(value: "num1")
        
        
        observerLetter.send(value: "concat2")
        observerLetter.send(value: "concat3")
        observerLetter.sendCompleted()
        observerNum.send(value: "end num")
        observerNum.sendCompleted()
        
        
        //属性绑定
        /*
         <~运算符提供了几种不同的绑定属性方式,MutablePropertyType类型的
         property <~ signal，将属性和信号绑定在一起，属性的值会根据信号送过来的值刷新
         property <~ producer, 启动这个producer，属性的值随着这个产生的信号送过来的值刷新
         property <~ otherProperty, 将这个属性和另一个属性绑定在一起，这个属性的值会随之源属性的值变化而变化
         */
        
    }
    
    //MARK: 信号
    public func racSignal() {
        //创建信号(冷信号)
        let producer = SignalProducer<String, NoError>.init { (observer, _) in
            YFLog("新的订阅，启动操作")
            observer.send(value: "😆")
            observer.send(value: "🤦‍♀️")
            observer.sendCompleted()
        }
        //多个观察者，每个接收的值相同
        let subscriber1 = Observer<String, NoError>(value: {YFLog("1 接收\($0)")})
        let subscriber2 = Observer<String, NoError>(value: {YFLog("2 接收\($0)")})
        producer.start(subscriber1)
        producer.start(subscriber2)
        
        //热信号,通过管道创建
        let (signalA, observerA) = Signal<String, NoError>.pipe()
        let (signalB, observerB) = Signal<String, NoError>.pipe()
        Signal.combineLatest(signalA, signalB).observeValues { (value) in
            YFLog("A is \(value.0) + B is \(value.1)")
        }
        //订阅信号要在send之前
        signalA.observeValues { (value) in
            YFLog("a is \(value)")
        }
        //不sendCompleted和sendError，热信号一直激活
        observerA.send(value: "😜")
        observerB.send(value: "木哈哈")
//        observerB.sendCompleted()
        //sendCompleted后再次发送没有意义
        observerB.send(value: "change")
        
        /*信号合并，合成后的新事件流只有在收到每个合成流的至少一个值后才会发送出去
        接着会把每个流的最新的值一起输出
         */
        let (signalC, observerC) = Signal<String, NoError>.pipe()
        let (signalD, observerD) = Signal<Array<Any>, NoError>.pipe()
        Signal.combineLatest(signalC, signalD).observeValues { (value) in
            YFLog("合并后的信号\(value)")
        }
        observerC.send(value: "C1")
        observerC.sendCompleted()
        observerD.send(value: ["Bilili","upup"])
        observerD.send(value: ["aaa","bbb"])
        observerD.sendCompleted()
        
        /*
         信号联合,zip中的信号都要被订阅才能激活，意味着如果是第一个流的N个元素，一定要等到另外一个流第N值也收到才会一起组合发出
         */
        let (signalX, observerX) = Signal<String, NoError>.pipe()
        let (signalY, observerY) = Signal<String, NoError>.pipe()
        
        //两个需要订阅才激活zip
        Signal.zip(signalX, signalY).observeValues { (value) in
            YFLog("zip: \(value)")
        }
        observerX.send(value: "1")
        observerX.send(value: "3")
        observerY.send(value: "2")
        observerY.send(value: "4")
        
    
    }
    //MARK: 监听
    public func racObserver() {
        var textField: UITextField!
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
        textField.reactive.continuousTextValues.observeValues { text in
            YFLog(text ?? "")
        }
        
        //监听粘贴进来的文本
        let result = textField.reactive.producer(forKeyPath: "text")
        result.start { (text) in
            YFLog("copy is \(text)")
        }
        
        //通知
        NotificationCenter.default.reactive.notifications(forName: Notification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil).observeValues { (notification) in
            YFLog("键盘弹出")
        }
        NotificationCenter.default.reactive.notifications(forName: Notification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil).observeValues { (notification) in
            YFLog("键盘隐藏")
        }
        
        //KVO
        let resultKVO = textField.reactive.producer(forKeyPath: "text")
        resultKVO.start { (text) in
            YFLog("KVO is \(text)")
        }
    }
    //MARK: 存根
    public func racDisposable() {
        //迭代器
        let array:[String] = ["A","B"]
        var arrayIterator = array.makeIterator()
        while let temp = arrayIterator.next() {
            YFLog("RACFun is \(temp)")
        }
        
        array.forEach { (value) in
            YFLog("swiftFun is \(value)")
        }
    }
    //MARK: 事件
    public func racEvent() {
        //调度器
        QueueScheduler.main.schedule(after: Date.init(timeIntervalSinceNow: 3)) { 
            YFLog("主线程3秒过去了")
        }
        
        QueueScheduler.init().schedule(after: Date.init(timeIntervalSinceNow: 2)) { 
            YFLog("子线程2秒过去了")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
