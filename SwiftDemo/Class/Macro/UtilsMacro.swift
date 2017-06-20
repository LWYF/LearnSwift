//
//  UtilsMacro.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/20.
//  Copyright © 2017年 lyf. All rights reserved.
//

import Foundation

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
