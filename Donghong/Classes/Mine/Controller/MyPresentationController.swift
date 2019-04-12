//
//  MyPresentationController.swift
//  Donghong
//
//  Created by Donghong on 2019/4/9.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class MyPresentationController: UIPresentationController {
    var presentFrame: CGRect?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissPresentedViewController), name: NSNotification.Name(rawValue: MyPresentationControllerDismiss), object: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = presentFrame!
        let coverView = UIView(frame: UIScreen.main.bounds)
        coverView.backgroundColor = .clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedViewController))
        coverView.addGestureRecognizer(tap)
        containerView?.insertSubview(coverView, at: 0)
    }
    
    @objc func dismissPresentedViewController() {
        presentedViewController.dismiss(animated: false, completion: nil)
    }
}
