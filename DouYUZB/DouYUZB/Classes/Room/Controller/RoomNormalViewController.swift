//
//  RoomNormalViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/15.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class RoomNormalViewController: BaseViewController,UIGestureRecognizerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        
        // setNavigationBarHidden隐藏时，手势左滑返回没有了，此时要设置interactivePopGestureRecognizer才起作用
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏顶部导航栏
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

}
