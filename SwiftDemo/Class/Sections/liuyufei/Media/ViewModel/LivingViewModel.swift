//
//  LivingViewModel.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/15.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

private let testLivingURL = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"

class LivingViewModel: NSObject {
    
    var livesModels = [livesModel]()
    
    override init() {
        super.init()
    }
    
    public func loadAsyncCompleted(succeed: @escaping([livesModel]) -> Void,
                            failure: @escaping(Any?) -> Void) {
        
        NetWorkRequest.sharedInstance.getRequest(testLivingURL, params: nil, success: {(response) in
            let model = LivingModel.init(response)
            if model.lives.count > 0 {
                succeed(model.lives)
            }
            
            }, failure: { (error) in
                YFLog("error is \(error)")
        })
    }
}
