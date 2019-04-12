//
//  PopoverAnimator.swift
//  Donghong
//
//  Created by Donghong on 2019/4/9.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            let toView = transitionContext.view(forKey: .to)
            toView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            transitionContext.containerView.addSubview(toView!)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView?.transform = .identity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        } else {
            let fromView = transitionContext.view(forKey: .from)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
            
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = MyPresentationController(presentedViewController: presented, presenting: presenting)
        pc.presentFrame = presentFrame
        return pc
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    
    var presentFrame: CGRect?
    
    var isPresent: Bool = false
    
    
}
