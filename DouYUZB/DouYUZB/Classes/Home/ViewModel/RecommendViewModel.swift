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
    lazy var hotGroup: AnchorGroup = AnchorGroup()
    lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    func loadData(finishCallback : @escaping () -> ()) {
        
        let params: [String : String] = ["limit" : "4","offset" : "0","time" : NSDate.getCurrentTime()]
        
        // 目的是等3个异步任务执行完才去更新数据
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        // 请求热门组数据
        NetworkUtils.request(type: .Get, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: ["time" : NSDate.getCurrentTime()]) { result in
            
            guard let result = result as? [String : NSObject] else {
                return
            }
            
            guard let data = result["data"] as? [[String : NSObject]] else {
                return
            }
            
            self.hotGroup.tag_name = "热门"
            self.hotGroup.icon_name = "home_header_hot"
            
            for item in data {
                let group = AnchorModel(dict: item)
                self.hotGroup.anchors.append(group)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        
        // 请求颜值组数据
        NetworkUtils.request(type: .Get, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: params) { result in
            print(result)
            
            guard let result = result as? [String : NSObject] else {
                return
            }
            
            guard let data = result["data"] as? [[String : NSObject]] else {
                return
            }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for item in data {
                let group = AnchorModel(dict: item)
                self.prettyGroup.anchors.append(group)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        
        // 请求首页下面几组的数据
        //  http://capi.douyucdn.cn/api/v1/getHotCate?limit=4?&offset=0&time=1474252024
        NetworkUtils.request(type: .Get, url: "http://capi.douyucdn.cn/api/v1/getHotCate", params: params) { result in
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
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            // 等3个异步执行完了，组织全部数据
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.hotGroup, at: 0)
            
            finishCallback()
        }
    }
}
