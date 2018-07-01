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
    
    var cycleModels: [CycleModel]? {
        didSet {
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
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
        
        cell.cycleModel = cycleModels?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
}

extension RecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滑动到一半时触发pageControl指示下一页
        let offset = scrollView.contentOffset.x + scrollView.bounds.width / 2
        
        pageControl.currentPage = Int(offset / scrollView.bounds.width)
    }
}
