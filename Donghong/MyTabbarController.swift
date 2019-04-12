//
//  ViewController.swift
//  Donghong
//
//  Created by Donghong on 2019/2/25.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class MyTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor(red: 245/255.0, green: 90/255.0, blue: 92/255.0, alpha: 1.0)
        // Do any additional setup after loading the view, typically from a nib.
        addChildViewController()
    }
    
    func addChildViewController() {
        setChildViewController(HomeViewController(), title: "Home", imageName: "home_tabbar_32x32_", selectedImageName: "home_tabbar_press_32x32_")
        setChildViewController(VideoViewController(), title: "Video", imageName: "video_tabbar_32x32_", selectedImageName: "video_tabbar_press_32x32_")
        setChildViewController(WeitoutiaoViewController(), title: "Weitoutiao", imageName: "huoshan_tabbar_32x32_", selectedImageName: "huoshan_tabbar_press_32x32_")
        setChildViewController(MineViewController(), title: "Mine", imageName: "mine_tabbar_32x32_", selectedImageName: "mine_tabbar_press_32x32_")
        setValue(MyTabBar(), forKey: "tabBar")
    }
    
    func setChildViewController(_ childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.title = title
        let navVc = MyNavigationController(rootViewController: childController)
        addChildViewController(navVc)
    }


}

