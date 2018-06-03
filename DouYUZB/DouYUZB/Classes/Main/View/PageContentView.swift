//
//  PageContentView.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/3.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

private let cellId = "ContentViewCell"

class PageContentView: UIView {

    private var childVCs: [UIViewController]
    
    private var parentVc: UIViewController
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    init(frame: CGRect,childVCs: [UIViewController],parentVc: UIViewController) {
        self.childVCs = childVCs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    private func setupUI() {
        for item in childVCs {
            parentVc.addChildViewController(item)
        }
        
        collectionView.frame = bounds
        addSubview(collectionView)
    }
}

extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let viewController = childVCs[indexPath.item]
        viewController.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(viewController.view)
        
        return cell
    }
}
