//
//  GameViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/8.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

fileprivate let edgeMargin: CGFloat = 10
fileprivate let itemWidth: CGFloat = (ScreenW - (edgeMargin * 2)) / 3
fileprivate let itemHeight: CGFloat = itemWidth * 6 / 5
fileprivate let headerHeight: CGFloat = 50
fileprivate let gameViewHeight: CGFloat = 90
fileprivate let cellId = "gameCellId"
fileprivate let headerId = "gameHeaderId"

class GameViewController: UIViewController {
    
    fileprivate lazy var viewModel: GameViewModel = GameViewModel()
    
    fileprivate lazy var topHeaderView: HomeCollectionHeaderView = {
        let headerView = HomeCollectionHeaderView.newInstance()
        headerView.frame = CGRect(x: 0, y: -(headerHeight + gameViewHeight), width: ScreenW, height: headerHeight)
        headerView.moreLabel.isHidden = true
        headerView.titleLabel.text = "常见"
        headerView.iconImage.image = UIImage(named: "Img_orange")
        return headerView
    }()
    
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.newInstance()
        gameView.frame = CGRect(x: 0, y: -gameViewHeight, width: ScreenW, height: gameViewHeight)
        return gameView
    }()
    
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.headerReferenceSize = CGSize(width: ScreenW, height: headerHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: edgeMargin, bottom: 0, right: edgeMargin)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!,collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = UIColor.white

        
        
        collectionView.dataSource = self
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
       
        collectionView.register(UINib(nibName: "HomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView.contentInset = UIEdgeInsets(top: headerHeight + gameViewHeight, left: 0, bottom: 0, right: 0)
        
        return collectionView
   
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }
}

extension GameViewController {
    func setupUI() {
        self.view.addSubview(collectionView)
        
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
    }
    
    func loadData() {
        self.viewModel.loadGameData {
            self.collectionView.reloadData()
            
            // 取前10个元素
            self.gameView.anchorGroups = Array(self.viewModel.gameModels[0..<10])
        }
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GameCollectionCell
        
        let model = self.viewModel.gameModels[indexPath.item]
        
        cell.gameModel = model
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomeCollectionHeaderView
        
        header.titleLabel.text = "全部"
        header.iconImage.image = UIImage(named: "Img_orange")
        header.moreLabel.isHidden = true
        
        return header
    }
}
