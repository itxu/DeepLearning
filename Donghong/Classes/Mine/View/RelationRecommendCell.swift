//
//  RelationRecommendCell.swift
//  Donghong
//
//  Created by Donghong on 2019/4/10.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class RelationRecommendCell: UICollectionViewCell {

    var userCard: UserCard? {
        didSet {
//            nameLabel.text = userCard?.user.info.name
//            avaterImageView.kf.setImage(with: URL(string: userCard!.user.info.avatar_url)!)
//            vImageView.isHidden = (userCard!.user.info.user_auth_info == "") ? true : false
//            recommendReasonLabel.text = userCard!.recommend_reason
        }
    }
    
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var vImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recommendReasonLabel: UILabel!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var concernButton: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.setTitleColor(.black, for: .normal)
        concernButton.setTitleColor(.red, for: .selected)
    }
    

    @IBAction func concernButtonClicked(_ sender: UIButton) {
        if sender.isSelected {
            NetworkTool.loadRelationUnfollow(user_id: userCard!.user.info.user_id, completionHandler: { (_) in
                sender.isSelected = !sender.isSelected
                self.loadingImageView.layer.removeAllAnimations()
                self.loadingImageView.isHidden = true
            })
        } else {
            NetworkTool.loadRelationFollow(user_id: userCard!.user.info.user_id, completionHandler: { (_) in
                sender.isSelected = !sender.isSelected
                self.loadingImageView.layer.removeAllAnimations()
                self.loadingImageView.isHidden = true
            })
        }
    }
    
}
