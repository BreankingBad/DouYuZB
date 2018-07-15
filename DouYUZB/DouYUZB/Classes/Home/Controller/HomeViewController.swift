//
//  HomeViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/1.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    private lazy var pageTitleView: PageTitleView = { [weak self] in
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        
        let view = PageTitleView(frame: CGRect(x: 0, y: StatusBarH + NavigationBarH, width: ScreenW, height: PageTitleViewH), titles:titles)
        
        view.pageTitleViewDelegate = self
        
        return view
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        
        let contentHeight = ScreenH - StatusBarH - NavigationBarH - PageTitleViewH - BottomTabLayoutH
        let frame = CGRect(x: 0, y: StatusBarH + NavigationBarH + PageTitleViewH, width: ScreenW,
                           height: contentHeight)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
//        for _ in 0...1 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
            
//        }
        let contentView = PageContentView(frame: frame, childVCs: childVcs, parentVc: self)
        contentView.pageContentViewDelegate = self
        
        return  contentView
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
        
        setupPageContentView()
    }
    
    private func setupPageContentView() {
        self.contentView.addSubview(pageContentView)
    }
    
    private func setupPageTitleView() {
        self.contentView.addSubview(pageTitleView)
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

extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(pageTitleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController: PageContentViewDelegate {
    func pageContentViewDidScroll(pageContentView: PageContentView, srollOffsetRatio: CGFloat) {
        pageTitleView.setTitleProgress(offsetRatio: srollOffsetRatio)
    }
}
