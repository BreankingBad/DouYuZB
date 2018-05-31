//
//  UIBarButtonItem-Extentsion.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/1.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String,
                                     imageHighlightName: String,
                                     size: CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageHighlightName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        self.init(customView: btn)
    }
}
