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

private let normalItemHeight: CGFloat = itemWidth * 3 / 4

private let prettyItemHeight: CGFloat = itemWidth * 4 / 3

private let headerHeight: CGFloat = 50

private let normalCellId = "normalCellId"

private let prettyCellId = "prettyCellId"

private let headerId = "headerId"


class RecommendViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = itemHorizontalMargin
        flowLayout.itemSize =  CGSize(width: itemWidth, height: normalItemHeight)
        flowLayout.headerReferenceSize = CGSize(width: ScreenW, height: headerHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: itemHorizontalMargin, bottom: 0, right: itemHorizontalMargin)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.white
        
        //设置子视图的宽度随着父视图变化
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        collectionView.register(UINib(nibName: "HomeCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: normalCellId)
        collectionView.register(UINib(nibName: "HomeCollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: prettyCellId)
        collectionView.register(UINib(nibName: "HomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
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
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellId, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellId, for: indexPath)
        }

        return cell
    }
}

extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: itemWidth, height: prettyItemHeight) 
        } else {
            return CGSize(width: itemWidth, height: normalItemHeight)
        }
    }
}
