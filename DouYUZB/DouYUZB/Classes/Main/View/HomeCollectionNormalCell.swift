//
//  HomeCollectionNormalCell.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/21.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class HomeCollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomImg: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            
            if anchor.online >= 10000 {
                let tenThousandValue = anchor.online / 10000
                onlineBtn.setTitle("\(tenThousandValue)w在线", for: .normal)
            } else {
                onlineBtn.setTitle("\(anchor.online)在线", for: .normal)
            }

            nickNameLabel.text = anchor.nickname
            roomNameLabel.text = anchor.room_name
            
            let url = URL(string: anchor.vertical_src)
            roomImg.kf.setImage(with: url)
            
        }
    }
}
