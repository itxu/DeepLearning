//
//  UserDetailHeaderView.swift
//  Donghong
//
//  Created by Donghong on 2019/3/19.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

let kUserDetailDongTaiCell = "kUserDetailDongTaiCell"

class UserDetailHeaderView: UIView, NibLoadable {
    
    
    var dongtais = [UserDetailDongtai]() {
        didSet {
            
        }
    }
    
    var userDetail: UserDetail? {
        didSet {
            backgroundImageView.kf.setImage(with: URL(string: userDetail!.bg_img_url)!)
            avatarImageView.kf.setImage(with: URL(string: userDetail!.avatar_url)!)
            vImageView.isHidden = !userDetail!.user_verified
            nameLabel.text = userDetail!.screen_name
            
            
            if userDetail!.verified_agency == "" {
                verifiedAgencyLabelHeight.constant = 0
                verifiedAgencyLabelTop.constant = 0
            }else{
                verifiedAgencyLabel.text = userDetail!.verified_agency + ": "
                verifiedContentLabel.text = userDetail!.verified_content
            }
            concernButton.isSelected = userDetail!.is_following
           // concernButton.backgroundColor = userDetail!.is_following? .grayColor232(): .globalRedColor()
            
            if userDetail!.area == "" {
                areaButton.isHidden = true
                areaButtonTop.constant = 0
                areaButtonHeight.constant = 0
            }else{
                areaButton.setTitle(userDetail!.area, for: .normal)
            }
            descriptionLabel.text = userDetail!.description as String
            if userDetail!.descriptionHeight! > 21 {
                unfoldButton.isHidden = false
                unfoldButtonWidth.constant = 40.0
            }
            
            recommendButtonWidth.constant = 0
            recommendTrailling.constant = 10.0
            
            
            followersCountLabel.text = userDetail!.followersCount
            followeringsCountLabel.text = userDetail!.followersCount
            
            
            
            if userDetail!.top_tab.count > 0 {
                for (index, topTab) in userDetail!.top_tab.enumerated() {
                    let button = UIButton(frame: CGRect(x: CGFloat(index)*topTabButtonWidth, y: 0, width: topTabButtonWidth, height: scrollView.height))
                    button.setTitle(topTab.show_name, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    button.setTitleColor(.black, for: .normal)
                    button.setTitleColor(.globalRedColor(), for: .selected)
                    button.addTarget(self, action: #selector(topTabButtonClicked), for: .touchUpInside)
                    scrollView.addSubview(button)
                    if index == 0 {
                        button.isSelected = true
                        privorButton = button
                    }
                    if index == userDetail!.top_tab.count - 1 {
                        scrollView.contentSize = CGSize(width: button.frame.maxX, height: scrollView.height)
                    }
                    let tableView = UITableView(frame: CGRect(x: CGFloat(index) * kWidth, y: 0, width: kWidth, height: scrollView.height))
                    
                    tableView.register(UserDetailDongTaiCell.self, forCellReuseIdentifier: kUserDetailDongTaiCell)
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.rowHeight = 130
                    
                    scrollView.addSubview(tableView)
                }
                scrollView.addSubview(indicatorView)
                //Error
                self.addSubview(indicatorView)
            } else {
                topTabHeight.constant = 0
                topTabView.isHidden = true
            }
            
            layoutIfNeeded()
            
        }
    }
    
    @objc func topTabButtonClicked(button: UIButton) {
        privorButton?.isSelected = false
        button.isSelected = !button.isSelected
        UIView.animate(withDuration: 0.25, animations: {
            self.indicatorView.centerX = button.centerX
        }){ (_) in
            self.privorButton = button
        }
    }
    
    @IBAction func sendMailButtonClicked() {
        
    }
    
    private lazy var indicatorView: UIView = {
        let indicatorView = UIView(frame: CGRect(x: (topTabButtonWidth-topTabindicatorWidth)*0.5, y: topTabView.height, width: topTabindicatorWidth, height: topTabindicatorHeight))
        indicatorView.backgroundColor = UIColor.globalRedColor()
        return indicatorView
    }()
    
    
    @IBAction func concernButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            NetworkTool.loadRelationUnfollow(user_id: userDetail!.user_id, completionHandler: { (_) in
                sender.isSelected = !sender.isSelected
                self.concernButton.backgroundColor = .red
                
                self.recommendButton.isHidden = true
                self.recommendButton.isSelected = false
                self.recommendButtonWidth.constant = 0
                self.recommendTrailling.constant = 0
                UIView.animate(withDuration: 0.25, animations: {
                    self.recommendButton.imageView?.transform = .identity
                    self.layoutIfNeeded()
                })
            })
        } else {
            NetworkTool.loadRelationFollow(user_id: userDetail!.user_id, completionHandler: {(_) in
                sender.isSelected = !sender.isSelected
                self.concernButton.backgroundColor = .green
                
                self.recommendButton.isHidden = false
                self.recommendButton.isSelected = false
                self.recommendButtonWidth.constant = 28
                self.recommendTrailling.constant = 15.0
                self.recommentHeight.constant = 223
                UIView.animate(withDuration: 0.25, animations: {
                    self.layoutIfNeeded()
                }, completion: { (_) in
                    self.resetLayout()
                    NetworkTool.loadRelationUserRecommend(user_id: self.userDetail!.user_id, completionHandler: { (userCards) in
                        print(self.userDetail?.user_id)
                        self.recommendView.addSubview(self.relationRecommendView)
                        self.relationRecommendView.userCards = userCards
                    })
                })
            })
        }
    }
    
    @IBAction func recommendButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        recommentHeight.constant = sender.isSelected ? 0 : 223.0
        UIView.animate(withDuration: 0.25, animations: {
            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(sender.isSelected ? Double.pi : 0))
            self.layoutIfNeeded()
        }){ (_) in
            self.resetLayout()
        }
    }
    
    @IBAction func unfoldButtonClicked() {
        unfoldButton.isHidden = true
        unfoldButtonWidth.constant = 0
        descriptionLabelHeight.constant = userDetail!.descriptionHeight!
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        }){ (_) in
            self.resetLayout()
        }
    }
    
    private func resetLayout() {
        baseView.height = topTabView.frame.maxX
        height = baseView.frame.maxY
    }
    
    
    weak var privorButton = UIButton()
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var vImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var toutiaohaoImageView: UIImageView!
    
    @IBOutlet weak var sendMailButton: UIButton!
    
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var areaButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var areaButtonTop: NSLayoutConstraint!
    
    @IBOutlet weak var concernButton: UIButton!
    
    @IBOutlet weak var recommendButton: UIButton!
    @IBOutlet weak var recommendButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var recommendViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recommendTrailling: NSLayoutConstraint!
    
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var verifiedAgencyLabel: UILabel!
    @IBOutlet weak var verifiedAgencyLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var verifiedAgencyLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var verifiedContentLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonTrailing: NSLayoutConstraint!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var followeringsCountLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var bgImageViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var topTabView: UIView!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var topTabHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomScrollView: UIScrollView!
    
    
    fileprivate lazy var relationRecommendView: RelationRecommendView = {
        let relationRecommendView = RelationRecommendView.loadViewFromNib()
        return relationRecommendView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        concernButton.setTitle("已关注", for: .normal)
        concernButton.setTitle("未关注", for: .selected)
    }
    
}


extension UserDetailHeaderView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dongtais.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailDongTaiCell, for: indexPath) as! UserDetailDongTaiCell
        cell.dongtai = dongtais[indexPath.row]
        return cell
    }
}
