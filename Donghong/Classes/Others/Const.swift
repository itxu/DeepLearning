//
//  Const.swift
//  Donghong
//
//  Created by Donghong on 2019/2/25.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

let kWidth = UIScreen.main.bounds.width
let screenWidth = UIScreen.main.bounds.width

let kHeight = UIScreen.main.bounds.height
let kTabBarHeight:CGFloat  = DH_DefineTool.deviceTabBarHeight()
let kNaviBarHeight:CGFloat = DH_DefineTool.deviceNaviBarHeight()
let kStatusBarHeight:CGFloat = kNaviBarHeight - 44


let BASE_URL = "https://is.snssdk.com"
let device_id: Int = 6096495334
let iid: Int = 5034850950

let isIPhoneX: Bool = kHeight == 812 ? true : false

let kMyHeaderViewHeight: CGFloat = 280
let kUserDetailHeaderBGImageViewHeight: CGFloat = 146

class DH_DefineTool: NSObject {
    
    class func deviceNaviBarHeight() -> CGFloat{
        var tempNaviHeight:CGFloat!
        switch kHeight {
        case 812.0,896.0:
            tempNaviHeight = 88.0
            break
        default:
            tempNaviHeight = 64.0
            break
        }
        return tempNaviHeight
    }
    
    class func deviceTabBarHeight() -> CGFloat{
        var tempTabBarHeight:CGFloat!
        switch kHeight {
        case 812.0,896.0:
            tempTabBarHeight = 83.0
            break
        default:
            tempTabBarHeight = 49.0
            break
        }
        return tempTabBarHeight
    }
}


let topTabButtonWidth: CGFloat = kWidth * 0.2
let topTabindicatorWidth: CGFloat = 40
let topTabindicatorHeight: CGFloat = 2

let MyPresentationControllerDismiss = "MyPresentationControllerDismiss"


/// 动态图片的宽高
// 图片的宽高
// 1        screenWidth * 0.5
// 2        (screenWidth - 35) / 2
// 3,4,5-9    (screenWidth - 40) / 3
let image1Width: CGFloat = screenWidth * 0.5
let image2Width: CGFloat = (screenWidth - 35) * 0.5
let image3Width: CGFloat = (screenWidth - 40) / 3
