//
//  VideoViewController.swift
//  Donghong
//
//  Created by Donghong on 2019/2/25.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    fileprivate let newsTitleTable = NewsTitleTable()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    lazy var navigationBar: HomeNavigationBar = {
        let navigationBar = HomeNavigationBar.loadViewFromNib()
        return navigationBar
    }()
    
}

extension VideoViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = navigationBar
        navigationBar.didSelectedAvatarButton = { [weak self] in
            self!.navigationController?.pushViewController(MineViewController(), animated: true)
        }
        
      
    }
}
