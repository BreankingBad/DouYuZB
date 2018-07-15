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

        setupPopGesture()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏底部tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }


}


extension BaseNavigationViewController {
    // 设置全屏pop手势
    func setupPopGesture() {
        guard let gestureRecognizer = interactivePopGestureRecognizer else {
            return
        }
        
        guard let view = gestureRecognizer.view else { return }
        
        guard let targets = gestureRecognizer.value(forKey: "_targets") as? [NSObject] else { return }
        
        guard let targetObj = targets.first else { return }
        
        guard let target = targetObj.value(forKey: "target") else {
            return
        }
        
        let action = Selector(("handleNavigationTransition:"))
        
        let popGesture = UIPanGestureRecognizer()
        view.addGestureRecognizer(popGesture)
        popGesture.addTarget(target, action: action)
    }
}
