//
//  GameCollectionCell.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/2.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit
import Kingfisher

class GameCollectionCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var anchor: AnchorGroup? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            
            title.text = anchor.tag_name
            
            let url = URL(string: anchor.icon_url)
            icon.kf.setImage(with: url, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
