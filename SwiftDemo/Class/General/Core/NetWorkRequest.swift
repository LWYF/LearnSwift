//
//  NetWorkRequest.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/15.
//  Copyright © 2017年 lyf. All rights reserved.
//

import Foundation
import Alamofire

public typealias successRequest = (_ response : [String : Any]) -> ()
public typealias failureRequest = (_ error: Error) -> ()


class NetWorkRequest: NSObject {
    static let sharedInstance = NetWorkRequest()
    private override init() {}
}

extension NetWorkRequest {
    func getRequest(_ url: String, params: Parameters?,
                          success: @escaping successRequest,
                          failure: @escaping failureRequest) {
        //默认为get方式
        request(url, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(_):
                if let result = response.result.value as? [String : Any] {
                    success(result)
                }
                break
            case .failure(_):
                if let result = response.result.error {
                    failure(result)
                }
                break
        }
    }
    }
    
    func postRequest(_ url: String, params: Parameters?,
                     success: @escaping successRequest,
                     failure: @escaping failureRequest) {
        request(url, method: .post, parameters: params).responseJSON { (response) in
            YFLog("post : \(response)")
        }
    }

}
