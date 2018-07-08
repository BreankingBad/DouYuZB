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

fileprivate let cellId = "gameCellId"

class GameViewController: UIViewController {
    
    fileprivate lazy var viewModel: GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHight)
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!,collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = UIColor.white
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: edgeMargin, bottom: 0, right: edgeMargin)
        
        collectionView.dataSource = self
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        return collectionView
   
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension GameViewController {
    func setupUI() {
        self.view.addSubview(collectionView)
        
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
}
