//
//  LivingModel.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/15.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

/*
 UInt8代表8位无符号整数
 Int8占用1个字节
 Int16相当于short，占用2个字节 -32768，32767
 Int32相当于Int,占用4个字节   -2147483648，2147483648
 Int64相当于long,占用8个字节
 32位平台，Int相当于Int32,64位平台,Int相当于Int64
 */
class LivingModel: BaseModel {
    var dm_error: Int = 0
    var error_msg: String = ""
    var lives: [livesModel] = [livesModel]()
    var expire_time: Int64 = 0
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "lives" {
            guard let livesArr = value as? [[String : Any]] else {
                return
            }
            for dict in livesArr {
                lives.append(livesModel.init(dict))
            }
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
}

class livesModel: BaseModel {
    var creater: CreatorModel = CreatorModel()
    var id: Int32 = 0
    var name: String = ""
    var city: String = ""
    var share_addr: String = ""
    var stream_addr: String = ""
    var version: Int32 = 0
    var slot: Int32 = 0
    var live_type: String = ""
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "creator" {
            guard let creatorArr = value as? [String : Any] else {
                return
            }
            creater = CreatorModel.init(creatorArr)
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
}

class CreatorModel: BaseModel {
    var id: Int32 = 0
    var level: Int32 = 0
    var gender: Int32 = 0
    var nick: String = ""
    var portrait: String = ""
}
