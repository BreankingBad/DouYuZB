//
//  CycleCollectionCell.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/1.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class CycleCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cycleImg: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel: CycleModel? {
        didSet {
            guard let cycleModel = cycleModel else {
                return
            }
            
            titleLabel.text = cycleModel.title
            
            let url = URL(string: cycleModel.pic_url)
            cycleImg.kf.setImage(with: url)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
