//
//  WeitoutiaoViewController.swift
//  Donghong
//
//  Created by Donghong on 2019/4/11.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class WeitoutiaoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }


}

extension WeitoutiaoViewController {
    private func setupUI() {
        //navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white"), for: .default)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.grayColor113()]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
    }
    
    @objc private func rightBarButtonItemClicked() {
        
    }
}
