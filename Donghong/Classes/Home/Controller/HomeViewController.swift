//
//  HomeViewController.swift
//  Donghong
//
//  Created by Donghong on 2019/2/25.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    fileprivate let newsTitleTable = NewsTitleTable()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    lazy var navigationBar: HomeNavigationBar = {
        let navigationBar = HomeNavigationBar.loadViewFromNib()
        return navigationBar
    }()
    
}

extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = navigationBar
        navigationBar.didSelectedAvatarButton = { [weak self] in
            self!.navigationController?.pushViewController(MineViewController(), animated: true)
        }
        
        NetworkTool.loadHomeNewsTitleData { (titles) in
            self.newsTitleTable.insert(titles)
        }
    }
}



//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let frame = CGRect(x: 100, y: 100, width: 30, height: 30)
//        let testView = UIButton(frame: frame)
//        testView.layer.opacity = 0
//        testView.backgroundColor = .orange
//        view.addSubview(testView)
//
//        let groupAnimation = CAAnimationGroup()
//        groupAnimation.beginTime = CACurrentMediaTime() + 0.5
//        groupAnimation.duration = 5
//
//
//        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
//        scaleDown.fromValue = 0
//        scaleDown.toValue = 1
//        let rotate = CABasicAnimation(keyPath: "transform.translation")
//        rotate.fromValue = CGPoint(x: 0, y: 0)
//        rotate.toValue = CGPoint(x: 15, y: 15)
//        let fade = CABasicAnimation(keyPath: "opacity")
//        fade.fromValue = 0.0
//        fade.toValue = 1.0
//
//        groupAnimation.animations = [scaleDown,rotate,fade]
//        testView.layer.add(groupAnimation, forKey: nil)
//
//    }
