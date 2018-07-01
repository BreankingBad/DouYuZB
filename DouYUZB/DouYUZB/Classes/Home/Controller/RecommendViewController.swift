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
    
    // viewModel类
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
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
        
        // 加载网络数据
        loadData()
    }

}

extension RecommendViewController {
    func setupUI() {
        self.view.addSubview(collectionView)
    }
}

extension RecommendViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomeCollectionHeaderView
        
        let group = recommendVM.anchorGroups[indexPath.section]
        
        headerView.group = group
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        if indexPath.section == 1 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellId, for: indexPath)
            as! HomeCollectionViewPrettyCell
            
            cell.anchor = anchor
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellId, for: indexPath) as! HomeCollectionNormalCell
            cell.anchor = anchor
            
            return cell
        }
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

extension RecommendViewController {
    func loadData() {
        recommendVM.loadData {
            self.collectionView.reloadData()
        }
    }
}
