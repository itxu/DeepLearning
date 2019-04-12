//
//  HomeNavigationBar.swift
//  Donghong
//
//  Created by Donghong on 2019/4/10.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class HomeNavigationBar: UIView, NibLoadable {
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var didSelectedAvatarButton: (()->())?
    var didSelectedSearchButton: (()->())?
    
    override func awakeFromNib() {
         super.awakeFromNib()
        searchButton.setImage(UIImage(named: "search_small_16x16_"), for: [.normal, .highlighted])
        //searchButton.backgroundColor
        searchButton.setTitleColor(.gray, for: .normal)
        searchButton.contentHorizontalAlignment = .left
        searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        searchButton.titleLabel?.lineBreakMode = .byTruncatingTail
        avatarButton.setImage(UIImage(named: "home_no_login_head"), for: .normal)
        avatarButton.setImage(UIImage(named: "home_no_login_head"), for: .highlighted)
        
        NetworkTool.loadHomeSearchSuggestInfo { (suggestInfo) in
            self.searchButton.setTitle(suggestInfo, for: .normal)
            
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
    
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: kWidth, height: 44)
        }
    }
    
    @IBAction func avatarButtonClicked(_ sender: Any) {
        didSelectedAvatarButton?()
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        didSelectedSearchButton?()
    }
    
    
    
}
