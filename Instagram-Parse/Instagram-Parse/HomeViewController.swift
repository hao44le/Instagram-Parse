//
//  HomeViewController.swift
//  Instagram-Parse
//
//  Created by Gelei Chen on 16/2/2016.
//  Copyright © 2016 Gelei Chen. All rights reserved.
//

import UIKit
import Parse
import MJRefresh

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var pageNum = 0
    var isHeaderRefresh = false
    var data : [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        self.setupTableRefresh()
        
        self.refreshData()
        
        // Do any additional setup after loading the view.
    }
    func configureView(){
        self.tableView.registerClass(ImageTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 300
        self.tableView.estimatedRowHeight = 120
    }
    func setupTableRefresh(){
        let header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.isHeaderRefresh = true
            self.pageNum = 0
            self.refreshData()
        })
        header.setTitle("Pull down to refresh", forState: MJRefreshState.Idle)
        header.setTitle("Release to refresh", forState: MJRefreshState.Pulling)
        header.setTitle("Loading ...", forState: MJRefreshState.Refreshing)
        header.stateLabel?.textColor = UIColor.blackColor()
        header.lastUpdatedTimeLabel?.hidden = true
        self.tableView.mj_header = header
        self.tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: { () -> Void in
            self.pageNum += 1
            self.refreshData()
        })
    }
    
    func refreshData(){
        
        Tool.showProgressHUD("Loading Photo")
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20 * (self.pageNum + 1)
        query.skip = 20 * self.pageNum

        query.findObjectsInBackgroundWithBlock { (object:[PFObject]?, error:NSError?) -> Void in
            Tool.dismissHUD()
            if self.tableView.mj_header.isRefreshing(){
                self.tableView.mj_header.endRefreshing()
            }
            if self.tableView.mj_footer.isRefreshing(){
                self.tableView.mj_footer.endRefreshing()
            }
            if self.isHeaderRefresh{
                self.isHeaderRefresh = false
                if nil != object {
                    self.data = object!
                    self.tableView.reloadData()
                    return
                }
                
            }
            if nil != object && object?.count != 0{
                self.data.appendContentsOf(object!)
//                print(object)
                self.tableView.reloadData()
            }
            
        }
      
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? ImageTableViewCell
        if cell == nil {
            cell = ImageTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        let userMedia = self.data[indexPath.row]
        let likes = userMedia.objectForKey("likesCount") as! NSNumber
        let media = userMedia.objectForKey("media") as! PFFile
        let commentsCount = userMedia.objectForKey("commentsCount") as! NSNumber
        let descriptionText = userMedia.objectForKey("caption") as! String
        cell!.userImage.image = UIImage(named: "icon")
        media.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
            if data != nil {
                cell!.userImage.image = UIImage(data: data!)
            }
        })
        
        cell!.likesLabel.text = "#Likes: \(likes.integerValue.description)"
        cell!.commentsCountLabel.text = "#Comments: \(commentsCount.integerValue.description)"
        cell!.detailTextView.text = descriptionText
        return cell!
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
