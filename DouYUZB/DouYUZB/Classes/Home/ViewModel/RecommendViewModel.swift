//
//  RecommendViewModel.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/28.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
}

extension RecommendViewModel {
    func loadData() {
        NetworkUtils.request(type: .Get, url: "http://httpbin.org/get", params: ["name" : "mxm"]) { result in
            print(result)
        }
    }
}
