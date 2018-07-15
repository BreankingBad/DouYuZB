//
//  AmuseViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/9.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

private let itemHorizontalMargin: CGFloat = 10

fileprivate let itemWidth: CGFloat = (ScreenW - itemHorizontalMargin * 3 ) / 2

private let normalItemHeight: CGFloat = itemWidth * 3 / 4

private let headerHeight: CGFloat = 50

private let menuViewHeight: CGFloat = 200

private let normalCellId = "normalCellId"

private let headerId = "headerId"

// 娱乐界面
class AmuseViewController: BaseViewController {
    
    // viewModel类
    private lazy var amuseViewModel: AmuseViewModel = AmuseViewModel()
    
    private lazy var menuView: AmuseMenuView = {
        let menuView = AmuseMenuView.newInstance()
        menuView.frame = CGRect(x: 0, y: -menuViewHeight, width: ScreenW, height: menuViewHeight)
        return menuView
    }()
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = itemHorizontalMargin
        flowLayout.itemSize =  CGSize(width: itemWidth, height: normalItemHeight)
        flowLayout.headerReferenceSize = CGSize(width: ScreenW, height: headerHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: itemHorizontalMargin, bottom: 0, right: itemHorizontalMargin)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.white
        
        //设置子视图的宽度随着父视图变化
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        collectionView.register(UINib(nibName: "HomeCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: normalCellId)

        collectionView.register(UINib(nibName: "HomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        showPageLoading()
        // 加载网络数据
        loadData()
    }
}

extension AmuseViewController {
    func setupUI() {
        self.contentView.addSubview(collectionView)
        
        collectionView.contentInset = UIEdgeInsets(top: menuViewHeight, left: 0, bottom: 0, right: 0)
        collectionView.addSubview(menuView)
        
        
    }
}

extension AmuseViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = amuseViewModel.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomeCollectionHeaderView
        
        let group = amuseViewModel.anchorGroups[indexPath.section]
        
        headerView.group = group
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = amuseViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
 
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellId, for: indexPath) as! HomeCollectionNormalCell
        cell.anchor = anchor
            
        return cell

    }
}

extension AmuseViewController {
    func loadData() {
        amuseViewModel.loadData {
            self.collectionView.reloadData()
            
            var groups = self.amuseViewModel.anchorGroups
//            groups.removeFirst()
            self.menuView.anchorGroups = groups
            
            self.hidePageLoading()
        }
    }
}
