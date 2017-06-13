//
//  AttributeInit.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

/**
 * 放初始化时内存消耗较大的对象
 */
import Foundation

extension DateFormatter {
    static let sharedInstance = DateFormatter()
}
