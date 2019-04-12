//
//  RelationRecommendView.swift
//  Donghong
//
//  Created by Donghong on 2019/4/10.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit
import Kingfisher

let kRelationRecommendCell = "RelationRecommendCell"

class RelationRecommendView: UIView, NibLoadable {

    var userCards = [UserCard]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.collectionViewLayout = RelationRecommendFlowLayout()
        collectionView.register(RelationRecommendCell.self, forCellWithReuseIdentifier: kRelationRecommendCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

}

extension RelationRecommendView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRelationRecommendCell, for: indexPath) as! RelationRecommendCell
        cell.userCard = userCards[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

class RelationRecommendFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: 142, height: 190)
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsetsMake(0,10,0,10)
    }
}

