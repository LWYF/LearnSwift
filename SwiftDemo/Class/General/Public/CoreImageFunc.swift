//
//  CoreImageFunc.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/20.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

//多数滤镜不是直接设置的，而是通过键值编码(KVC)设置
class CoreImageFunc: NSObject {

    //获取系统滤镜列表
    func allFilterNames() -> [String] {
        //根据名称创建滤镜let filter == CIFilter(named: "CIGaussianBlur")
        return CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
    }
}
