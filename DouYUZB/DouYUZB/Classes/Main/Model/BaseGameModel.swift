//
//  BaseGameModel.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/8.
//  Copyright © 2018年 mxm. All rights reserved.
//

import Foundation

class BaseGameModel: NSObject {
    // 组名
    var tag_name: String = ""
    
    // 房间图标url(游戏布局会用到)
    var icon_url: String = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    /// 因为有些key没有定义，所以为了避免报错，重新该方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
