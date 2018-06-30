//
//  AnchorGroup.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/30.
//  Copyright © 2018年 mxm. All rights reserved.
//

import Foundation

// 主播组模型
class AnchorGroup: NSObject {
    // 房间列表
    var room_list: [[String: NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            
            for room in room_list {
                let anchorModel = AnchorModel(dict: room)
                anchors.append(anchorModel)
            }
        }
    }
    
    // 组名
    var tag_name: String = ""
    
    var icon_name: String = "home_header_normal"
    
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    /// 因为有些key没有定义，所以为了避免报错，重新该方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
