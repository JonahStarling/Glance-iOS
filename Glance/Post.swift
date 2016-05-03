//
//  Post.swift
//  Glance
//
//  Created by Jonah Starling on 4/9/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import Foundation

class Post {
    var postType: String
    var userName: String
    var userHandle: String
    var postTime: String
    var userPic: String
    var postText: String
    var postPic: String
    var link: String
    
    //Default Initializer
    init() {
        self.postType = ""
        self.userName = "User"
        self.userHandle = "@User"
        self.postTime = ""
        self.userPic = ""
        self.postText = "Example Post"
        self.postPic = ""
        self.link = ""
    }
    
    // Full Initializer
    init(postType: String, userName: String, userHandle: String, postTime: String, userPic: String, postText: String, postPic: String, link: String) {
        self.postType = postType
        if (userName == "") {
            self.userName = userHandle
        } else {
            self.userName = userName
        }
        self.userHandle = "@"+userHandle
        let time = NSDate(timeIntervalSince1970:Double(postTime)!)
        self.postTime = time.description
        self.userPic = userPic
        self.postText = postText
        self.postPic = postPic
        self.link = link
    }
    
    // Get Functions
    func getPostType() -> String { return self.postType }
    func getUserName() -> String { return self.userName }
    func getUserHandle() -> String { return self.userHandle }
    func getPostTime() -> String { return  self.postTime }
    func getUserPic() -> String { return self.userPic }
    func getPostText() -> String { return self.postText }
    func getPostPic() -> String { return self.postPic }
    func getLink() -> String { return self.link }
    
    // Set Functions
    func setPostType(postType: String) { self.postType = postType }
    func setUserName(userName: String) { self.userName = userName }
    func setUserHandle(userHandle: String) { self.userHandle = userHandle }
    func setPostTime(postTime: String) { self.postTime = postTime }
    func setUserPic(userPic: String) { self.userPic = userPic }
    func setPostText(postText: String) { self.postText = postText }
    func setPostPic(postPic: String) { self.postPic = postPic }
    func setLink(link: String) { self.link = link }
}