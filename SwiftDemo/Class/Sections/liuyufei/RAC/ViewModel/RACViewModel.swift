//
//  RACViewModel.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

/**
 MVVM的核心，解耦合，处理逻辑
 */

class RACViewModel: NSObject {
    var values = [RACModel]()

    override init() {
        super.init()
    }
    
    //@escaping意味着必须在闭包里显示引用self
    //逃逸闭包常见于异步操作
    func loadAsyncCompleted(succeed: @escaping(Any?) -> Void, failure: @escaping(Any?) -> Void) {
        let racContent:[[String : Any]] = [["title" : "Signal"], ["title": "Disposable"],["title" : "Event"], ["title" : "Observer"]]
        
        for dict in racContent {
            let model = RACModel.init(dict)
            self.values.append(model)
        }
        if self.values.count > 0 {
            succeed(self.values)
        }
        else {
            failure("error")
        }
    }
}
    
