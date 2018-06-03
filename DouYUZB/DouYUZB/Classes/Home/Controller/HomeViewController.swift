//
//  HomeViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/1.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var pageTitleView: PageTitleView = {
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        
        let view = PageTitleView(frame: CGRect(x: 0, y: StatusBarH + NavigationBarH, width: ScreenW, height: PageTitleViewH), titles:titles)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension HomeViewController {
    
    private func setupUI() {
        setupNavigationBar()
        
        setupPageTitleView()
    }
    
    private func setupPageTitleView() {
        self.view.addSubview(pageTitleView)
    }
    
    private func setupNavigationBar() {
        
        // 设置左边logo
        let logoBtn = UIButton()
        logoBtn.setImage(UIImage(named: "logo"), for: .normal)
        let logo = UIBarButtonItem(customView: logoBtn)
        self.navigationItem.leftBarButtonItem = logo;
        
        
        // 设置右边三个按钮
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "btn_history", imageHighlightName: "btn_history_clicked", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", imageHighlightName: "btn_search_clicked", size: size)
        let scanItem = UIBarButtonItem(imageName: "btn_scan", imageHighlightName: "btn_scan_clicked", size: size)
        
        self.navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
    }
}
