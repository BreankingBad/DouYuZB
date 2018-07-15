//
//  BaseViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/15.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var contentView: UIView = { [unowned self] in
        let contentView = UIView()
        contentView.frame = self.view.frame
        return contentView
    }()
    
    lazy var pageloadingView: UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.animationImages = [UIImage(named: "img_loading_1")!,
                                     UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        
        imageView.center = self.view.center
        
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        imageView.isHidden = true

        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        setupUI()
       self.view.backgroundColor = UIColor.init(red: 250, green: 250, blue: 250)
        
        self.view.addSubview(contentView)
        self.view.addSubview(pageloadingView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        contentView.frame = self.view.bounds
    }
    
//    func setupUI() {
//
//    }
}

extension BaseViewController {
    func showPageLoading() {
        pageloadingView.startAnimating()
        contentView.isHidden = true
        pageloadingView.isHidden = false
    }
    
    func hidePageLoading() {
        pageloadingView.stopAnimating()
        contentView.isHidden = false
        pageloadingView.isHidden = true
    }
}
