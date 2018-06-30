//
//  NetworkUtils.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/28.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case Get
    case Post
}

class NetworkUtils {
    
    class func request(type: MethodType, url: String, params: [String : String]? = nil, callback: @escaping (_ result: Any) -> ()) {
        
        let method = type == .Get ? HTTPMethod.get : HTTPMethod.post
        
        // 发送网络请求
        Alamofire.request(url, method: method, parameters: params)
            .responseJSON { response in
                // 获取结果
                guard let result = response.result.value else {
                    print(response.result.error ?? "data error")
                    return
                }
                
                // 回调通知
                callback(result)
            }
        
        
    }
}
