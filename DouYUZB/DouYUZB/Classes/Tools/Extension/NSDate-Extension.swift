//
//  NSDate-Extension.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/30.
//  Copyright © 2018年 mxm. All rights reserved.
//

import Foundation

extension NSDate {
    
    // 获取当前的时间
    class func getCurrentTime() -> String {
        let date = NSDate()
        
        let interval = Int(date.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
