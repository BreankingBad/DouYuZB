//
//  BaseNavigationViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/15.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏底部tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }


}
