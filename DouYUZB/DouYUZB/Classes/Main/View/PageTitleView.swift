//
//  PageTitleView.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/3.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

private let normalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let selectedColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


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
        
        currentIndex = tapLabel.tag
        
        for (index, item) in titleLabels.enumerated() {
            if index == currentIndex {
               item.textColor = UIColor.orange
            } else {
               item.textColor = UIColor.darkGray
            }
        }
        
        // 动画过渡设置指示条的位置
        UIView.animate(withDuration: 0.15) {
            self.indicatorLine.frame.origin.x = CGFloat(self.currentIndex) * self.indicatorLine.frame.width
        }
        
        pageTitleViewDelegate?.pageTitleView(pageTitleView: self, selectedIndex: currentIndex)
    }
}

extension PageTitleView {
    // 设置标签显示进度
    func setTitleProgress(offsetRatio: CGFloat) {
        self.indicatorLine.frame.origin.x = offsetRatio * self.indicatorLine.frame.width
        
        // 取值0～1之间，颜色由普通颜色到选中颜色
        let colorProgress = offsetRatio - floor(offsetRatio)
        
        // 较小值的index
        let smallIndex = Int(floor(offsetRatio))
        // 较大值的index
        let bigIndex = Int(ceil(offsetRatio))
        
        let smallLabel = titleLabels[smallIndex]
        let bigLabel = titleLabels[bigIndex]
        
        // 设置当前页码
        currentIndex =  Int(round(offsetRatio))
        
        let colorRange = (selectedColor.0 - normalColor.0, selectedColor.1 - normalColor.1,
                          selectedColor.2 - normalColor.2)
        
        // 设置较大标签的文字颜色
        bigLabel.textColor = UIColor(red:normalColor.0 +  colorProgress * colorRange.0,
                                     green: normalColor.1 +  colorProgress * colorRange.1,
                                     blue: normalColor.2 + colorProgress * colorRange.2)
        
        // 设置较小标签的文字颜色
        smallLabel.textColor = UIColor(red:normalColor.0 +  (1 - colorProgress) * colorRange.0,
                                       green: normalColor.1 +  (1 - colorProgress) * colorRange.1,
                                       blue: normalColor.2 + (1 - colorProgress) * colorRange.2)
        
        
        
    }
}
