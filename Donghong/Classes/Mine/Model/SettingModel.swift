//
//  SettingModel.swift
//  Donghong
//
//  Created by Donghong on 2019/3/6.
//  Copyright © 2019 Donghong. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel: HandyJSON {
    var title: String = "a"
    var subtitle: String = "b"
    var rightTitle: String = "c"
    var isHiddenSubtitle: Bool = false
    var isHiddenRightTitle: Bool = false
    var isHiddenSwitch: Bool = false
    var isHiddenRightArrow: Bool = false
}
