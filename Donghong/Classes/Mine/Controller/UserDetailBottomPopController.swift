//
//  UserDetailBottomPopController.swift
//  Donghong
//
//  Created by Donghong on 2019/4/7.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class UserDetailBottomPopController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    //var children = [BottomTabChildren]()
    
    var childrenGroup = [BottomTabChildren]()
    var didSelectedChild: ((BottomTabChildren)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenGroup.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.selectionStyle = .none
        let child = childrenGroup[indexPath.row]
        cell.textLabel?.text = child.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: MyPresentationControllerDismiss), object: nil)
        didSelectedChild?(childrenGroup[indexPath.row])
        
    }
}
