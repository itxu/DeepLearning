//
//  NavigationBarView.swift
//  Donghong
//
//  Created by Donghong on 2019/4/9.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class NavigationBarView: UIView, NibLoadable {
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var goBackButtonClicked: (()->())?
    
    @IBAction func returnButtonClicked(_ sender: UIButton) {
        goBackButtonClicked?()
    }
    
    @IBAction func moreButtonClicked(_ sender: UIButton) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        height = navigationBar.frame.maxY
    }
}
