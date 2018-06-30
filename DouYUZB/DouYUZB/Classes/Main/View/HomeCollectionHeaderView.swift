//
//  HomeCollectionHeaderView.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/21.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class HomeCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImage.image = UIImage(named: group?.icon_name ?? "home_header_hot")
        }
    }
    
}
