//
//  MyNavigationController.swift
//  Donghong
//
//  Created by Donghong on 2019/3/6.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initGlobalPan()
        navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
    }
    
    @objc func navigationBack() {
        popViewController(animated: true)
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }

    
}

extension MyNavigationController: UIGestureRecognizerDelegate {
    fileprivate func initGlobalPan(){
        let target = interactivePopGestureRecognizer?.delegate
        let globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        globalPan.delegate = self
        view.addGestureRecognizer(globalPan)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count != 1
    }
}
