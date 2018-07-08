//
//  RecommendGameView.swift
//  DouYUZB
//
//  Created by mxm on 2018/7/2.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

private let cellId = "gameCellId"

class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var anchorGroups: [BaseGameModel]? {
        didSet {
            
            
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置大小不随着父视图变化而变化
        autoresizingMask = []
        
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.showsHorizontalScrollIndicator = false
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 80, height: self.bounds.height)

    }

}

extension RecommendGameView {
    class func newInstance() -> RecommendGameView {
       return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GameCollectionCell
        
        cell.gameModel = anchorGroups?[indexPath.item]
        return cell
    }
}
