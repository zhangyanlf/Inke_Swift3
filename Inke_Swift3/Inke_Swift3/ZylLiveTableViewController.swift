//
//  ZylLiveTableViewController.swift
//  Inke_Swift3
//
//  Created by 张彦林 on 17/6/6.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit
import Just
import Kingfisher


class ZylLiveTableViewController: UITableViewController {
    let liveListUrl = "http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"
    var list: [ZylCell] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadList()
        //下拉刷新
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadList), for: .valueChanged)
        
    }
    func loadList() {
        Just.post(liveListUrl) { (r) in
            guard let json = r.json as? NSDictionary else {
                return
            }
            let lives = ZylliveStream(fromDictionary: json).lives!
            
            self.list = lives.map({ (live) -> ZylCell in
                return ZylCell(portrait: live.creator.portrait, nick: live.creator.nick, location: live.creator.location, viewers: live.onlineUsers, url: live.streamAddr)
            })
            dump(self.list)
            //更新界面
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InkeCell", for: indexPath) as! ZylTableViewCell
        let live = list[indexPath.row]
        
        cell.location.text = live.location
        cell.nikeLabel.text = live.nick
        cell.viewersLabel.text = "\(live.viewers)"
        
        //小头像
        let imgUrl = URL(string: "" + live.portrait)
       
        
        cell.portraitImg.kf.setImage(with: imgUrl)
        
        //大头像
        cell.portraitBigImg.kf.setImage(with: imgUrl)

        return cell
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        navigationController?.setNavigationBarHidden(true, animated: true)
        let dest = segue.destination as! ViewController
        
        dest.live = list[(tableView.indexPathForSelectedRow?.row)!]
        
    }
    

}
