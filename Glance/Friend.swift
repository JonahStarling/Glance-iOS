//
//  Friend.swift
//  Glance
//
//  Created by Jonah Starling on 4/14/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import Foundation

class Friend {
    var postType: String
    var userName: String
    var userHandle: String
    var userPic: String
    
    // Default Initializer
    init() {
        self.postType = ""
        self.userName = "User"
        self.userHandle = "@User"
        self.userPic = ""
    }
    
    // Full Initializer
    init(postType: String, userName: String, userHandle: String, userPic: String) {
        self.postType = postType
        if (userName == "") {
            self.userName = userHandle
        } else {
            self.userName = userName
        }
        self.userHandle = userHandle
        self.userPic = userPic
    }
    
    // Get Functions
    func getPostType() -> String { return self.postType }
    func getUserName() -> String { return self.userName }
    func getUserHandle() -> String { return self.userHandle }
    func getUserPic() -> String { return self.userPic }
    
    // Set Functions
    func setPostType(postType: String) { self.postType = postType }
    func setUserName(userName: String) { self.userName = userName }
    func setUserHandle(userHandle: String) { self.userHandle = userHandle }
    func setUserPic(userPic: String) { self.userPic = userPic }
}