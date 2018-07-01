//
//  HomeCollectionViewPrettyCell.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/24.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCollectionViewPrettyCell: UICollectionViewCell {

    @IBOutlet weak var roomImg: UIImageView!
    @IBOutlet weak var onlineLabel: UILabel!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            
            if anchor.online >= 10000 {
                let tenThousandValue = anchor.online / 10000
                onlineLabel.text = "\(tenThousandValue)w在线"
            } else {
                onlineLabel.text = "\(anchor.online)在线"
            }
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            nickNameLabel.text = anchor.nickname
            
            let url = URL(string: anchor.vertical_src)
            roomImg.kf.setImage(with: url)
            
        }
    }
    
}
