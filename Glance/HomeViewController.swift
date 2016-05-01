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
    
    let instagramService = InstagramServices()
    
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
        cell.postImage.kf_setImageWithURL(NSURL(string: post.postPic)!,optionsInfo: [.Transition(ImageTransition.Fade(1))])
        cell.userProfilePicture.kf_setImageWithURL(NSURL(string: post.userPic)!)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "postsLoadedNotification:", name: "postsLoaded", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "callGetRelevantPosts:", name: "getBestFriendsCompleteCallGetRelevantPosts", object: nil)
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
        if (instagramService.bestFriends.isEmpty) {
            instagramService.loadBestFriendsFromDB()
        } else {
            instagramService.getRelevantPosts()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postsLoadedNotification(notif: NSNotification) {
        print("postsLoadedNotification was handled")
        self.tableView.reloadData()
    }
    
    func callGetRelevantPosts(notif: NSNotification) {
        print("callGetRelevantPosts was handled")
        instagramService.getRelevantPosts()
    }

}

