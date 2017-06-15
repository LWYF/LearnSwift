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
    var dm_error: Any?
    var error_msg: String?
    var lives: livesModel?
    var expire_time: Any?
    
}

class livesModel: BaseModel {
    var creater: CreatorModel?
    var id: Int32?
    var name: String?
    var city: String?
    var share_addr: String?
    var stream_addr: String?
    var version: Int32?
    var slot: Int32?
    var live_type: String?
}

class CreatorModel: BaseModel {
    var id: Int32?
    var level: Int32?
    var gender: Int32?
    var nick: String?
    var portrail: String?
}
