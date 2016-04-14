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
    var postTime: Int
    var userPic: String
    var postText: String
    var postPic: String
    
    //Default Initializer
    init() {
        self.postType = ""
        self.userName = "User"
        self.userHandle = "@User"
        self.postTime = -1
        self.userPic = ""
        self.postText = "Example Post"
        self.postPic = ""
    }
    
    // Full Initializer
    init(postType: String, userName: String, userHandle: String, postTime: Int, userPic: String, postText: String, postPic: String) {
        self.postType = postType
        if (userName == "") {
            self.userName = userHandle
        } else {
            self.userName = userName
        }
        self.userHandle = userHandle
        self.postTime = postTime
        self.userPic = userPic
        self.postText = postText
        self.postPic = postPic
    }
    
    // Get Functions
    func getPostType() -> String { return self.postType }
    func getUserName() -> String { return self.userName }
    func getUserHandle() -> String { return self.userHandle }
    func getPostTime() -> Int { return  self.postTime }
    func getUserPic() -> String { return self.userPic }
    func getPostText() -> String { return self.postText }
    func getPostPic() -> String { return self.postPic }
    
    // Set Functions
    func setPostType(postType: String) { self.postType = postType }
    func setUserName(userName: String) { self.userName = userName }
    func setUserHandle(userHandle: String) { self.userHandle = userHandle }
    func setPostTime(postTime: Int) { self.postTime = postTime }
    func setUserPic(userPic: String) { self.userPic = userPic }
    func setPostText(postText: String) { self.postText = postText }
    func setPostPic(postPic: String) { self.postPic = postPic }
}