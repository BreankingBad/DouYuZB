//
//  AmuseMenuCell.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/14.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

private let cellId = "amuseMenuCellId"

class AmuseMenuCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var anchorGroups: [BaseGameModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: collectionView.bounds.width / 4, height: collectionView.bounds.height / 2)
//        layout.scrollDirection = .vertical
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
    }

}

extension AmuseMenuCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GameCollectionCell
    
        
        cell.gameModel = anchorGroups?[indexPath.item]
        
        cell.clipsToBounds = true
        
        return cell
    }
}

