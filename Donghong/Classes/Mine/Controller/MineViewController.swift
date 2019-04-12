//
//  MineViewController.swift
//  Donghong
//
//  Created by Donghong on 2019/3/11.
//  Copyright © 2019 Donghong. All rights reserved.
//
import RxSwift
import RxCocoa
import UIKit

class MineViewController: UITableViewController {
    
    var sections = [[MyCellModel]]()
    var concerns = [MyConcern]()
    
    
    
    fileprivate let bag = DisposeBag()
    
    fileprivate lazy var headerView: NoLoginHeaderView = {
        let headerView = NoLoginHeaderView.loadViewFromNib()
        return headerView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden((false), animated: false)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if #available(iOS 11.0, *){
//            tableView.contentInsetAdjustmentBehavior = .never
//        }else{
//            automaticallyAdjustsScrollViewInsets = false
//        }

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        tableView.register(UINib(nibName: String(describing: MyOtherCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyOtherCell.self))
        tableView.register(UINib(nibName: String(describing: MyFirstSectionCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyFirstSectionCell.self))
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        NetworkTool.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_test\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections
            self.tableView.reloadData()
            
            NetworkTool.loadMyConcern(completionHandler: { (concerns) in
                self.concerns = concerns
                let indexSet = IndexSet(integer: 0)
                self.tableView.reloadSections(indexSet, with: .automatic)
            })
        }
        
        headerView.moreLoginButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [unowned self] in
                let storyboard = UIStoryboard(name: String(describing: MoreLoginViewController.self), bundle: nil)
                let moreLoginVC = storyboard.instantiateViewController(withIdentifier: String(describing: MoreLoginViewController.self)) as! MoreLoginViewController
                self.present(moreLoginVC, animated: true, completion: nil)
            })
            
            .disposed(by: bag)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = kMyHeaderViewHeight + abs(offsetY)
            let f = totalOffset / kMyHeaderViewHeight
            headerView.bgImageView.frame = CGRect(x: -kWidth * (f - 1) * 0.5, y: offsetY, width: kWidth * f, height: totalOffset)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 8 : 18
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 10))
        view.backgroundColor = UIColor(r: 247, g: 248, b: 249)
        return view
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyFirstSectionCell.self)) as! MyFirstSectionCell
            let section = sections[indexPath.row]
            cell.myCellModel = section[indexPath.row]
            if concerns.count == 0 || concerns.count == 1 {
                cell.collectionView.isHidden = true
            }
            if concerns.count == 1 {
                cell.myConcern = concerns[0]
            }
            if concerns.count > 1 {
                cell.myConcerns = concerns
            }
            cell.delegate = self as MyFirstSectionCellDelegate
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyOtherCell.self)) as! MyOtherCell
        cell.accessoryType = .disclosureIndicator
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
        cell.leftLabel.text = myCellModel.text
        cell.rightLabel.text = myCellModel.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 {
            if indexPath.row == 1 {
                let settingVC = SettingViewController()
                settingVC.navigationItem.title = "设置"
                navigationController?.pushViewController(settingVC, animated: true)
            }
        }
    }
 
}

extension MineViewController: MyFirstSectionCellDelegate {

    
    func MyFirstSectionCell1(_ firstCell: MyFirstSectionCell, myConcern: MyConcern) {
        let userDetailVC = UserDetailViewController()
        userDetailVC.userId = myConcern.userid!
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}
