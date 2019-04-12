//
//  OfflineDownloadController.swift
//  Donghong
//
//  Created by Donghong on 2019/3/14.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

class OfflineDownloadController: UITableViewController {
    
    fileprivate var titles = [HomeNewsTitle]()
    fileprivate let newsTitleTable = NewsTitleTable()
    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.register(UINib(nibName: "OfflineDownloadCell", bundle: nil), forCellReuseIdentifier: "OfflineDownloadCell")
        tableView.rowHeight = 44
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //tableView.register(OfflineDownloadCell.self, forCellReuseIdentifier: "OfflineDownloadCell")
        NetworkTool.loadHomeNewsTitleData { (titles) in
            self.titles = titles
            print("titles.count = \(self.titles.count)")
            self.tableView.reloadData()
            
            self.titles = self.newsTitleTable.selectAll()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 44))
        view.backgroundColor = UIColor.globalBackgroundColor()
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: kWidth, height: 44))
        lable.text = "我的频道"
        view.addSubview(lable)
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return titles.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfflineDownloadCell", for: indexPath) as! OfflineDownloadCell
        let newTitle = titles[indexPath.row]
        cell.fuckyou.text = newTitle.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var homeNewsTitle = titles[indexPath.row]
        homeNewsTitle.selected = !homeNewsTitle.selected
        let cell = tableView.cellForRow(at: indexPath) as! OfflineDownloadCell
        let url = homeNewsTitle.selected ? "air_download_option_20x20_":"air_download_option_press_20x20_"
        cell.rightImage.image = UIImage(named: url)
        titles[indexPath.row] = homeNewsTitle
        newsTitleTable.update(homeNewsTitle)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
