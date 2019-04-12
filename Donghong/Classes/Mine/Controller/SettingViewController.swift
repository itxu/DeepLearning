//
//  SettingViewController.swift
//  Donghong
//
//  Created by Donghong on 2019/3/13.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit
import Kingfisher

class SettingViewController: UITableViewController {

    var sections = [[SettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        for dicts in cellPlist {
            let array = dicts as! [[String: Any]]
            var rows = [SettingModel]()
            for dict in array {
                let setting = SettingModel.deserialize(from: dict as NSDictionary)
                rows.append(setting!)
            }
            sections.append(rows)
        }
        
        /*
         sections = cellPlist.flatMap({section in
         (section as@ [Any]).flatMap({row in
         SettingModel.deserialize(from: row as? NSDictionary)
         })
         })
         */
        
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = sections[section]
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingCell.self)) as! SettingCell
       // let cell = UITableViewCell()
        let rows = sections[indexPath.section]
        let setting = rows[indexPath.row]
        cell.setting = setting
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                calculateDiskCache(cell)
            default: break
            }
        default:
            break
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.row) \(indexPath.section)")
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                clearCacheAlertController(cell)
            case 1:
                setupFontAlertController(cell)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let offlineDownloadVC = OfflineDownloadController()
                navigationController?.pushViewController(offlineDownloadVC, animated: true)
                offlineDownloadVC.navigationItem.title = "离线下载"
            default:
                break
            }
        default:
            break
        }
    }

}

extension SettingViewController {
    fileprivate func calculateDiskCache(_ cell: SettingCell) {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskStorageSize { (result) in
            guard result.isSuccess else {
                return
            }
            let sizeM = Double(result.value!) / 1024.0 / 1024.0
            let sizeString = String(format: "%.2fM", sizeM)
            cell.rightTitleLabel.text = sizeString
        }
    }
    
    
    
    fileprivate func clearCacheAlertController(_ cell: SettingCell) {
        let alertController = UIAlertController(title: "清除所有缓存？", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            cell.rightTitleLabel.text = "0.0M"
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension SettingViewController {
    fileprivate func setupFontAlertController(_ cell: SettingCell) {
        let alertController = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "小"
        })
        let middleAction = UIAlertAction(title: "中", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "中"
        })
        alertController.addAction(cancelAction)
        alertController.addAction(smallAction)
        alertController.addAction(middleAction)
        present(alertController, animated: true, completion: nil)
    }
}
