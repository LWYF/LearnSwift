//
//  RAC.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

import Foundation
import ReactiveSwift

//用于给某个对象的属性绑定
struct RAC {
    var target: NSObject!
    var keyPath: String!
    var nilValue: AnyObject!
    
    init(_ target: NSObject!, _ keyPath: String!, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }    
}
