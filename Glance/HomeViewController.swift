//
//  HomeViewController.swift
//  Glance
//
//  Created by Jonah Starling on 1/9/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UITableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostStore.sharedInstance.getCount()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InstagramPost", forIndexPath: indexPath) as! InstagramPost
        let post = PostStore.sharedInstance.getPostAt(indexPath.row)
        cell.userFullName.text = post.userName
        cell.userHandle.text = post.userHandle
        cell.postTime.text = post.postTime
        cell.postCaption.text = post.postText
        cell.postImage.kf_setImageWithURL(NSURL(string: post.postPic)!)
        cell.userProfilePicture.kf_setImageWithURL(NSURL(string: post.userPic)!)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 254
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

