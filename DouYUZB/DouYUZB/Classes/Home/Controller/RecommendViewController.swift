//
//  RecommendViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/6/18.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

private let itemHorizontalMargin: CGFloat = 10

fileprivate let itemWidth: CGFloat = (ScreenW - itemHorizontalMargin * 3 ) / 2

private let normalItemHeight: CGFloat = itemWidth * 3 / 4

private let prettyItemHeight: CGFloat = itemWidth * 4 / 3

private let cycleViewHeight: CGFloat = ScreenW * 3 / 8

private let gameViewHeight: CGFloat = 90

private let headerHeight: CGFloat = 50

private let normalCellId = "normalCellId"

private let prettyCellId = "prettyCellId"

private let headerId = "headerId"


class RecommendViewController: BaseViewController {
    
    // viewModel类
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    private lazy var cycleView: RecommendCycleView = { [weak self] in
        let cycleView = RecommendCycleView.newInstance()
        
        cycleView.frame = CGRect(x: 0, y: -(cycleViewHeight + gameViewHeight), width: ScreenW, height: cycleViewHeight)
        return cycleView
    }()
    
    private lazy var gameView: RecommendGameView = { [weak self] in
        let gameView = RecommendGameView.newInstance()
        gameView.frame = CGRect(x: 0, y: -gameViewHeight, width: ScreenW, height: gameViewHeight)
        return gameView  
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
        
        showPageLoading()
        // 加载网络数据
        loadData()
    }

}

extension RecommendViewController {
    func setupUI() {
        self.contentView.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        // 设置内边距，使cycleView一开始就能显示出来
        collectionView.contentInset = UIEdgeInsets(top: cycleViewHeight + gameViewHeight, left: 0, bottom: 0, right: 0)
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

extension RecommendViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        if anchor.isVertical == 0 {
            let roomVc = RoomNormalViewController()
            self.navigationController?.pushViewController(roomVc, animated: true)
        } else {
            let showVc = RoomShowViewController()
            present(showVc, animated: true)
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
            
            var models = self.recommendVM.anchorGroups
            // 移除第一组和第二组（热门和颜值）
            models.removeFirst()
            models.removeFirst()
            let moreBtn = AnchorGroup()
            moreBtn.tag_name = "更多"
            // 在数组最后添加更多按钮
            models.append(moreBtn)
            
            // 取前10个元素
            self.gameView.anchorGroups = models
            
            
            self.hidePageLoading()
        }
        
        recommendVM.loadCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}
