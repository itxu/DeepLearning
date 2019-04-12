//
//  UserDetailViewController.swift
//  Donghong
//
//  Created by Donghong on 2019/3/16.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewBottom: NSLayoutConstraint!
    
    var userId: Int = 0
    var userDetail: UserDetail?
    
    fileprivate lazy var headerView: UserDetailHeaderView = {
        let headerView = UserDetailHeaderView.loadViewFromNib()
        return headerView
    }()
    
    fileprivate lazy var myBottomView: UserDetailBottomView = {
        let m = UserDetailBottomView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 44))
        m.delegate = self
        return m
    }()
    
    fileprivate lazy var navigationBar: NavigationBarView = {
        let navigationBar = NavigationBarView.loadViewFromNib()
        return navigationBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        view.backgroundColor = .white
        scrollView.addSubview(headerView)
        scrollView.contentSize = CGSize(width: kWidth, height: 1000)
        scrollView.delegate = self
        
        view.addSubview(navigationBar)
        navigationBar.goBackButtonClicked = {
            self.navigationController?.popViewController(animated: true)
        }
        
        bottomViewBottom.constant = isIPhoneX ? 34: 0
        view.layoutIfNeeded()
        
        userId = 51025535398
        NetworkTool.loadUserDetail(user_id: userId) { (userDetail) in
            NetworkTool.loadUserDetailDongtaiList(user_id: self.userId, completionHandler: { (dongtais) in
                self.userDetail = userDetail
                self.headerView.userDetail = userDetail
                self.navigationBar.nameLabel.text = self.headerView.nameLabel.text
                //self.headerView.dongtais = dongtais
                self.headerView.dongtais = dongtais
                if userDetail.bottom_tab.count == 0 {
                    self.bottomViewBottom.constant = 0
                    self.view.layoutIfNeeded()
                }else{
                    self.bottomView.addSubview(self.myBottomView)
                    self.myBottomView.bottomTabs = userDetail.bottom_tab
                }
            })
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return changeStatusBarStyle
    }
    
    var changeStatusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}

extension UserDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < -44 {
            let totalOffset = kUserDetailHeaderBGImageViewHeight + abs(offsetY)
            let f = totalOffset / kUserDetailHeaderBGImageViewHeight
            headerView.backgroundImageView.frame = CGRect(x: -kWidth * (f - 1) * 0.5, y: offsetY, width: kWidth * f, height: totalOffset)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        } else {
            var alpha: CGFloat = (offsetY + 44) / 58
            alpha = min(alpha, 1.0)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: alpha)
            if alpha == 1.0 {
                changeStatusBarStyle = .default
                navigationBar.returnButton.setImage(UIImage(named: "personal_home_back_black_24x24_"), for: .normal)
                navigationBar.moreButton.setImage(UIImage(named: "new_more_titlebar_24x24_"), for: .normal)
            } else {
                changeStatusBarStyle = .lightContent
                navigationBar.returnButton.setImage(UIImage(named: "personal_home_back_white_24x24_"), for: .normal)
                navigationBar.moreButton.setImage(UIImage(named: "new_morewhite_titlebar_22x22_"), for: .normal)
            }
            
            var alpha1: CGFloat = offsetY / 57
            if offsetY >= 43 {
                alpha1 = min(alpha1, 1.0)
                navigationBar.nameLabel.isHidden = false
                navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
            } else {
                alpha1 = min(0.0, alpha1)
                navigationBar.nameLabel.isHidden = true
                navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
            }
        }
    }
}

extension UserDetailViewController: UserDetailBottomViewDelegate {
    
    func bottomView(clicked button: UIButton, bottomTab: BottomTab) {
        let bottomPushVC = UserDetailBottomPushControlle()
        bottomPushVC.navigationItem.title = "网页浏览"
        
        if bottomTab.children.count == 0 {
            bottomPushVC.url = bottomTab.value
            navigationController?.pushViewController(bottomPushVC, animated: true)
        } else {
            let sb = UIStoryboard(name: "\(UserDetailBottomPopController.self)", bundle: nil)
            let popoverVC = sb.instantiateViewController(withIdentifier: "\(UserDetailBottomPopController.self)") as! UserDetailBottomPopController
            popoverVC.childrenGroup = bottomTab.children
            popoverVC.modalPresentationStyle = .custom
            
            popoverVC.didSelectedChild = {
                bottomPushVC.url = $0.value
                self.navigationController?.pushViewController(bottomPushVC, animated: true)
            }
            
            let popoverAnimator = PopoverAnimator()
            
            let rect = myBottomView.convert(button.frame, to: view)
            let popWidth = (kWidth - CGFloat(userDetail!.bottom_tab.count + 1) * 20) / CGFloat(userDetail!.bottom_tab.count)
            let popX = CGFloat(button.tag) * (popWidth + 20) + 20
            let popHeight = CGFloat(bottomTab.children.count) * 40 + 25
            popoverAnimator.presentFrame = CGRect(x: popX, y: rect.origin.y - popHeight, width: popWidth, height: popHeight)
            
            popoverVC.transitioningDelegate = popoverAnimator
            present(popoverVC, animated: true, completion: nil)
            
        }
    }
}
