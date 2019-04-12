//
//  UIColor+Extension.swift
//  Donghong
//
//  Created by Donghong on 2019/2/25.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    class func globalBlackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    class func globalRedColor() -> UIColor {
        return UIColor(r: 132, g: 132, b: 132)
    }
    
    class func grayColor232() -> UIColor {
        return UIColor(r: 232, g: 232, b: 232)
    }
    
    class func grayColor113() -> UIColor {
        return UIColor(r: 113, g: 113, b: 113)
    }
}
