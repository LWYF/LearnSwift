//
//  AppGlobal.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let NAVIGATIONBARHEIGHT: CGFloat = 64
let STATUSBARHEIGHT: CGFloat = 20
let TABBARHEIGHT: CGFloat = 49
let MARGIN: CGFloat = 10

//调试信息
func YFLog<T>(_ message: T, file: String = #file, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("file:\(fileName)\nline:\(lineNumber)\n\(message)")
    #endif
}
