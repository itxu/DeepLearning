//
//  UserDetailBottomPushControlle.swift
//  Donghong
//
//  Created by Donghong on 2019/4/7.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit
import WebKit

class UserDetailBottomPushControlle: UIViewController {
    
    var url: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView()
        webView.frame = view.bounds
        webView.load(URLRequest(url: URL(string: url!)!))
        view.addSubview(webView)
    }
    

}
