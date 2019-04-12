//
//  MyConcernCell.swift
//  Donghong
//
//  Created by Donghong on 2019/3/12.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit
import Kingfisher

class MyConcernCell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vipImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var myConcern: MyConcern? {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: (myConcern?.icon)!))
            nameLabel.text = myConcern?.name
            if let isVerify = myConcern?.is_verify {
                vipImageView.isHidden = !isVerify
            }
        }
    }

}
