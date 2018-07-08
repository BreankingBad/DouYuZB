//
//  GameViewModel.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/8.
//  Copyright © 2018年 mxm. All rights reserved.
//

import Foundation

class GameViewModel {
    lazy var gameModels: [BaseGameModel] = [BaseGameModel]()
}

extension GameViewModel {
    
    func loadGameData(finishedCallback: @escaping () -> Void) {
        NetworkUtils.request(type: .Get, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName:game", params: [:]) { result in
            guard let result = result as? [String : Any] else { return }
            guard let dataArray = result["data"] as? [[String : Any]] else { return }
            
            for data in dataArray {
                self.gameModels.append(GameModel(dict: data))
            }
            
            finishedCallback()
        }
    }
}
