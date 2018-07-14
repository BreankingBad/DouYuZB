//
//  AmuseMenuView.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/14.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class AmuseMenuView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let menuCellId = "amuseMenuViewCellId"
    
    var anchorGroups: [BaseGameModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = []
        
        collectionView.register(UINib(nibName: "AmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: menuCellId)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = collectionView.bounds.size
        layout.scrollDirection = .horizontal
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

}

extension AmuseMenuView {
    static func newInstance() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var pageCount = 1
        guard let anchorGroups = anchorGroups else {
            return pageCount
        }
        
        pageCount = (anchorGroups.count  - 1) / 8 + 1
        
        pageControl.numberOfPages = pageCount
        
        return pageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! AmuseMenuCell
        
        guard let anchorGroups = anchorGroups else {
            return cell
        }
        
        let firstIndex = indexPath.item * 8
        var lastIndex = (indexPath.item + 1) * 8 - 1
        
        if lastIndex > anchorGroups.count - 1 {
            lastIndex = anchorGroups.count - 1
        }
        let groups = anchorGroups[firstIndex...lastIndex]
        cell.anchorGroups = Array(groups)
        
        return cell
    }
}

extension AmuseMenuView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let curPage = (Int)(scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = curPage
    }
}
