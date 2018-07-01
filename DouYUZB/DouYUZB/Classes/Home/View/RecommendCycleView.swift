//
//  RecommendCycleView.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/1.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

private let cellId = "cycleCellId"

class RecommendCycleView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var cycleTimer: Timer?
    
    var cycleModels: [CycleModel]? {
        didSet {
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            // 默认滚动到中间一个位置，这样就可以向左滚动
            let startIndex = IndexPath(item: (cycleModels?.count)! * 100, section: 0)
            collectionView.scrollToItem(at: startIndex, at: .left, animated: false)
            
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    deinit {
        removeCycleTimer()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置大小不随着父视图变化而变化
        autoresizingMask = []
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CycleCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    override func layoutSubviews() {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        // 如果在awakeFromNib获取self.bounds.size，那么获取到的是xib设置的大小，
        // 是不准确的，要在layoutSubviews获取
        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
    }
}

extension RecommendCycleView {
    class func newInstance() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        as! CycleCollectionCell
        
        // 无限循环
        cell.cycleModel = cycleModels?[indexPath.item % (cycleModels?.count ?? 1)]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 无限循环
        return (cycleModels?.count ?? 0) * 10000
    }
}

extension RecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滑动到一半时触发pageControl指示下一页
        let offset = scrollView.contentOffset.x + scrollView.bounds.width / 2
        
        pageControl.currentPage = Int(offset / scrollView.bounds.width) %
        (cycleModels?.count ?? 1)
    }
}

extension RecommendCycleView {
    
    // 自动循环，3秒一次
    func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(goNextPage), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    @objc func goNextPage() {
        let nextOffset = collectionView.contentOffset.x + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
    }
    
    func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 拖动时停止循环切换
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
         // 停止拖动时开始循环切换
        addCycleTimer()
    }
}
