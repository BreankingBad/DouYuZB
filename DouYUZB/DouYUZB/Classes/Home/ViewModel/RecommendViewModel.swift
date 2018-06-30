//
//  RecommendViewModel.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/28.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension RecommendViewModel {
    func loadData() {
        //  http://capi.douyucdn.cn/api/v1/getHotCate?limit=4?&offset=0&time=1474252024
        NetworkUtils.request(type: .Get, url: "http://capi.douyucdn.cn/api/v1/getHotCate", params: ["limit" : "4","offset" : "0","time" : NSDate.getCurrentTime()]) { result in
            print(result)
            
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
            
            for group in self.anchorGroups {
                print("-------------")
                for room in group.anchors {
                    print(room.nickname)
                }
            }
        }
    }
}
