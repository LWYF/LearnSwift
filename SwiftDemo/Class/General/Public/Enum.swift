//
//  Enum.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

import Foundation

/**
 * RAC的主要类型
 */
public enum RACType: String {
    case unknown = ""
    case signal = "Signal"
    case disposable = "Disposable"
    case event = "Event"
    case observer = "Observer"
}

/*
 * 加载动画的方式
 */

public enum LoadingAnimationType {
    //多个点横向滚动
    case point
    //多个点以圆的方式滚动
    case cirle
}


