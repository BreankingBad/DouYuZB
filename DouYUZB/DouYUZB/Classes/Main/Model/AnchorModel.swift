//
//  AnchorModel.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/30.
//  Copyright © 2018年 mxm. All rights reserved.
//

import Foundation

// 主播模型
class AnchorModel: NSObject {
    // 房间ID
    var room_id: Int = 0
    
    // 房间名
    var room_name: String = ""
    
    // 在线人数
    var online: Int = 0
    
    // 用电脑直播还是手机直播 0 电脑 1 手机
    var isVertical: Int = 0
    
    // 房间图片
    var vertical_src: String = ""
    
    // 主播名称
    var nickname: String = ""
    
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    /// 因为有些key没有定义，所以为了避免报错，重新该方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
