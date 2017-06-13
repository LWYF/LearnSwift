//
//  RACModel.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

class RACModel: NSObject {

    var title: String = ""
    
    init(_ dict: [String : Any]) {
        super.init()
        //字典转model
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
