//
//  AccountViewController.swift
//  Glance
//
//  Created by Jonah Starling on 5/1/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import UIKit
import Kingfisher

class AccountViewController: UITableViewController {
    
    let instagramService = InstagramServices()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendStore.sharedInstance.getCount()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendCell
        let friend = FriendStore.sharedInstance.getFriendAt(indexPath.row)
        cell.userFullName.text = friend.userName
        cell.userHandle.text = friend.userHandle
        cell.userProfilePic.kf_setImageWithURL(NSURL(string: friend.userPic)!)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "friendsLoadedNotification:", name: "friendsLoaded", object: nil)
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (instagramService.bestFriends.isEmpty) {
            instagramService.loadBestFriendsFromDB()
        } else {
            instagramService.getBestFriends()
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func friendsLoadedNotification(notif: NSNotification) {
        print("friendsLoadedNotification was handled")
        self.tableView.reloadData()
    }
}