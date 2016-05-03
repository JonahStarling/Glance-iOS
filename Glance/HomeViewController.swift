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
        var date:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        date = dateFormatter.dateFromString(post.postTime)!
        cell.postTime.text = offsetFrom(date)
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
        self.tableView.reloadData()
    }
    
    func callGetRelevantPosts(notif: NSNotification) {
        instagramService.getRelevantPosts()
    }
    
    func yearsFrom(date:NSDate, currentDate:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: currentDate, options: []).year
    }
    func monthsFrom(date:NSDate, currentDate:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: currentDate, options: []).month
    }
    func weeksFrom(date:NSDate, currentDate:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: currentDate, options: []).weekOfYear
    }
    func daysFrom(date:NSDate, currentDate:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: currentDate, options: []).day
    }
    func hoursFrom(date:NSDate, currentDate:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: currentDate, options: []).hour
    }
    func minutesFrom(date:NSDate, currentDate:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: currentDate, options: []).minute
    }
    func secondsFrom(date:NSDate, currentDate:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: currentDate, options: []).second
    }
    func offsetFrom(date:NSDate) -> String {
        var todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let dateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        todaysDate = dateFormatter.dateFromString(dateInFormat)!
        if yearsFrom(date, currentDate: todaysDate)   > 0 { return "\(yearsFrom(date, currentDate: todaysDate))y"   }
        if monthsFrom(date, currentDate: todaysDate)  > 0 { return "\(monthsFrom(date, currentDate: todaysDate))M"  }
        if weeksFrom(date, currentDate: todaysDate)   > 0 { return "\(weeksFrom(date, currentDate: todaysDate))w"   }
        if daysFrom(date, currentDate: todaysDate)    > 0 { return "\(daysFrom(date, currentDate: todaysDate))d"    }
        if hoursFrom(date, currentDate: todaysDate)   > 0 { return "\(hoursFrom(date, currentDate: todaysDate))h"   }
        if minutesFrom(date, currentDate: todaysDate) > 0 { return "\(minutesFrom(date, currentDate: todaysDate))m" }
        if secondsFrom(date, currentDate: todaysDate) > 0 { return "\(secondsFrom(date, currentDate: todaysDate))s" }
        return ""
    }
    
}

