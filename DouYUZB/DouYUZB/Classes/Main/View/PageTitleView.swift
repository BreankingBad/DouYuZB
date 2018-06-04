//
//  PageTitleView.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/3.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(pageTitleView: PageTitleView,selectedIndex index: Int)
}

class PageTitleView: UIView {
    
    // 当前下标
    private var currentIndex: Int = 0
    
    var pageTitleViewDelegate: PageTitleViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var indicatorLine: UIView = {
       let line = UIView()
       line.backgroundColor = UIColor.orange
       return line
    }()
    
    private var titles: [String]
    
    private var titleLabels = [UILabel]()

    init(frame: CGRect, titles: [String]) {
        self.titles = titles;
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    
    private func setupUI() {
        setupTitleLabels()
        
        setupBottomLine()
        
        setupIndicatorLine()
    }
    
    private func setupTitleLabels() {
        
        // 首先添加scrollView
        scrollView.frame = bounds
        addSubview(scrollView)
        
        // 再往scrollView添加label
        let labelW = ScreenW / CGFloat(titles.count)
        let labelH = CGFloat(PageTitleViewH)
        let labelY: CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            // 设置tag
            label.tag = index
            
            // 给label添加点击手势
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTap))
            label.addGestureRecognizer(tapGesture)
            
            let labelX = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLine() {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        line.frame = CGRect(x: 0, y: frame.height - LineW, width: frame.width, height: LineW)
        addSubview(line)
    }
    
    private func setupIndicatorLine() {
        guard let firstLabel = titleLabels.first else {
            return
        }
        
        firstLabel.textColor = UIColor.orange
        
        indicatorLine.frame = CGRect(x: firstLabel.frame.origin.x, y: bounds.height - IndicatorLineW, width: firstLabel.frame.width, height: IndicatorLineW)
        addSubview(indicatorLine)
        
    }
}

extension PageTitleView {
    @objc func onTap(sender: UIGestureRecognizer){
        
        print("tap working")
        
        let tapLabel = sender.view as! UILabel
        
        let lastLabel = titleLabels[currentIndex]
        
        tapLabel.textColor = UIColor.orange
        lastLabel.textColor = UIColor.darkGray
        
        currentIndex = tapLabel.tag
        
        // 动画过渡设置指示条的位置
        UIView.animate(withDuration: 0.15) {
            self.indicatorLine.frame.origin.x = CGFloat(self.currentIndex) * self.indicatorLine.frame.width
        }
        
        pageTitleViewDelegate?.pageTitleView(pageTitleView: self, selectedIndex: currentIndex)
    }
}
