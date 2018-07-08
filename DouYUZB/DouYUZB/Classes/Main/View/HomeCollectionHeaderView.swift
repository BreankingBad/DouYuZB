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
    
    @IBOutlet weak var moreLabel: UILabel!
    
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImage.image = UIImage(named: group?.icon_name ?? "home_header_hot")
        }
    }
    
}

extension HomeCollectionHeaderView {
    static func newInstance() -> HomeCollectionHeaderView {
        return Bundle.main.loadNibNamed("HomeCollectionHeaderView", owner: nil, options: nil)?.first as! HomeCollectionHeaderView
    }
}
