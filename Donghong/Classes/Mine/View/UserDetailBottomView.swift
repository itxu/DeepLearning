//
//  UserDetailBottomView.swift
//  Donghong
//
//  Created by Donghong on 2019/4/6.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

protocol UserDetailBottomViewDelegate: class {
    func bottomView(clicked button: UIButton,bottomTab: BottomTab)
}

class UserDetailBottomView: UIView {
    
    weak var delegate: UserDetailBottomViewDelegate?
    
    var bottomTabs = [BottomTab]() {
        didSet {
            let buttonWidth = (kWidth - CGFloat(bottomTabs.count)) / CGFloat(bottomTabs.count)
            for (index, bottomTab) in bottomTabs.enumerated() {
                let button = UIButton(frame: CGRect(x: CGFloat(index) * ( buttonWidth + 1), y: 0, width: buttonWidth, height: height))
                button.setTitle(bottomTab.name, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.setImage(UIImage(named: "tabbar-options_9x9_"), for: .normal)
                
                button.tag = index
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.addTarget(self, action: #selector(bottomTabButtonClicked), for: .touchUpInside)
                addSubview(button)
                
                if index < bottomTabs.count - 1 {
                    let separatorView = UIView(frame: CGRect(x: button.frame.maxX, y: 6, width: 1, height: 33))
                    addSubview(separatorView)
                }
            }
        }
    }
    
    @objc func bottomTabButtonClicked(button: UIButton) {
        let bottomTab = bottomTabs[button.tag]
        delegate?.bottomView(clicked: button, bottomTab: bottomTab)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
