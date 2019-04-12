//
//  UIButton+Extension.swift
//  Donghong
//
//  Created by Donghong on 2019/2/28.
//  Copyright © 2019 Donghong. All rights reserved.
//
import UIKit

extension UIButton {
    func setButtonMiddle() {
        if imageView == nil || titleLabel == nil{
            return
        }
        let imgW:CGFloat = imageView!.frame.size.width
        let imgH:CGFloat = imageView!.frame.size.height
        let lblW:CGFloat = titleLabel!.frame.size.width
        let lblH:CGFloat = titleLabel!.frame.size.height
        //设置图片和文字的间距，这里可自行调整
        let margin:CGFloat = 5
        imageEdgeInsets = UIEdgeInsets(top: -lblH-margin/2, left: 0, bottom: 0, right: -lblW)
        titleEdgeInsets = UIEdgeInsets(top: imgH+margin/2, left: -imgW, bottom: 0, right: 0)
    }
}
