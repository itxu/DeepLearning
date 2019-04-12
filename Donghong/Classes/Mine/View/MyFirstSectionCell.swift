//
//  MyFirstSectionCell.swift
//  Donghong
//
//  Created by Donghong on 2019/3/11.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

protocol MyFirstSectionCellDelegate: class {
    func MyFirstSectionCell1( _ firstCell: MyFirstSectionCell, myConcern: MyConcern)
}

class MyFirstSectionCell: UITableViewCell {

    weak var delegate: MyFirstSectionCellDelegate?
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myConcerns = [MyConcern]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var myCellModel: MyCellModel? {
        didSet {
            leftLabel.text = myCellModel?.text
            rightLabel.text = myCellModel?.grey_text
        }
    }
    
    var myConcern: MyConcern? {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.collectionViewLayout = MyConcernFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: String(describing: MyConcernCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MyConcernCell.self))
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MyFirstSectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyConcernCell.self), for: indexPath) as! MyConcernCell
        cell.myConcern = myConcerns[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myConcern = myConcerns[indexPath.item]
        delegate?.MyFirstSectionCell1(self, myConcern: myConcern)
    }

    
}


class MyConcernFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        itemSize = CGSize(width: 58, height: 74)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollDirection = .horizontal
    }
}
