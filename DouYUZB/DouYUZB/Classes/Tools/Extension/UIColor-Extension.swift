//
//  UIColor-Extension.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/3.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / CGFloat(255), green: green / CGFloat(255), blue: blue / CGFloat(255),
                   alpha: 1)
    }
    
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)), green: CGFloat(arc4random_uniform(256)), blue: CGFloat(arc4random_uniform(256)))
    }
}
