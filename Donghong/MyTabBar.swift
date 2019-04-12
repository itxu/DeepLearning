//
//  MyTabBar.swift
//  Donghong
//
//  Created by Donghong on 2019/2/25.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(publishButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var  publishButton: UIButton = {
        let publicButton = UIButton(type: .custom)
        publicButton.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        publicButton.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .selected)
        publicButton.sizeToFit()
        return publicButton
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = frame.width
        //let height = frame.height
        publishButton.center = CGPoint(x: width * 0.5, y: 49/2)
        
        let buttonW: CGFloat = width * 0.2
        let buttonH: CGFloat = 49
        let buttonY: CGFloat = 0
        var index = 0
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) { continue }
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            index += 1
        }
    }
    
    
}
