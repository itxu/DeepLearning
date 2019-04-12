//
//  MyOtherCell.swift
//  Donghong
//
//  Created by Donghong on 2019/3/11.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell {

    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
