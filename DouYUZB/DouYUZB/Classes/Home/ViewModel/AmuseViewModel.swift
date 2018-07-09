//
//  AmuseViewModel.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/9.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class AmuseViewModel: NSObject {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    func loadData(finishCallback : @escaping () -> ()) {
       
        NetworkUtils.request(type: .Get, url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { result in
            
            guard let result = result as? [String : NSObject] else {
                return
            }
            
            guard let data = result["data"] as? [[String : NSObject]] else {
                return
            }
            
            for item in data {
                let group = AnchorGroup(dict: item)
                self.anchorGroups.append(group)
            }

            finishCallback()
        }
        
    }
}

