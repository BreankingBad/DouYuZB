//
//  RecommendViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/18.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

private let itemHorizontalMargin: CGFloat = 10

private let itemWidth: CGFloat = (ScreenW - itemHorizontalMargin * 3 ) / 2

private let itemHeight: CGFloat = itemWidth * 3 / 4

private let headerHeight: CGFloat = 40

private let normalCellId = "normalCellId"

private let headerId = "headerId"


class RecommendViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = itemHorizontalMargin
        flowLayout.itemSize =  CGSize(width: itemWidth, height: itemHeight)
        flowLayout.headerReferenceSize = CGSize(width: ScreenW, height: headerHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: itemHorizontalMargin, bottom: 0, right: itemHorizontalMargin)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        
        //设置子视图的宽度随着父视图变化
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        collectionView.backgroundColor = UIColor.red
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: normalCellId)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension RecommendViewController {
    func setupUI() {
        self.view.addSubview(collectionView)
    }
}

extension RecommendViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        headerView.backgroundColor = UIColor.blue
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellId, for: indexPath)
        
        cell.backgroundColor = UIColor.purple
        return cell
    }
}
