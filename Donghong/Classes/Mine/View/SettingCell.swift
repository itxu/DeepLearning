//
//  SettingCell.swift
//  Donghong
//
//  Created by Donghong on 2019/3/13.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    var setting: SettingModel? {
        didSet {
            titleLabel.text = setting!.title
            rightTitleLabel.text = setting!.rightTitle
           // rightSwitch.isHidden = setting!.isHiddenSwitch
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
