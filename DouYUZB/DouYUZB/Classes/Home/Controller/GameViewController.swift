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
fileprivate let itemHight: CGFloat = itemWidth * 6 / 5
fileprivate let headerHight: CGFloat = 50
fileprivate let cellId = "gameCellId"
fileprivate let headerId = "gameHeaderId"

class GameViewController: UIViewController {
    
    fileprivate lazy var viewModel: GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHight)
        flowLayout.headerReferenceSize = CGSize(width: ScreenW, height: headerHight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: edgeMargin, bottom: 0, right: edgeMargin)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!,collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = UIColor.white

        
        
        collectionView.dataSource = self
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
       
        collectionView.register(UINib(nibName: "HomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
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
    }
    
    func loadData() {
        self.viewModel.loadGameData {
            self.collectionView.reloadData()
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
