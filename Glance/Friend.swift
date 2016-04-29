//
//  Friend.swift
//  Glance
//
//  Created by Jonah Starling on 4/14/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import Foundation

class Friend {
    var friendType: String
    var userName: String
    var userId: String
    var userHandle: String
    var userPic: String
    
    // Default Initializer
    init() {
        self.friendType = ""
        self.userName = "User"
        self.userId = ""
        self.userHandle = "@User"
        self.userPic = ""
    }
    
    // Full Initializer
    init(friendType: String, userName: String, userId: String, userHandle: String, userPic: String) {
        self.friendType = friendType
        if (userName == "") {
            self.userName = userHandle
        } else {
            self.userName = userName
        }
        self.userId = userId
        self.userHandle = userHandle
        self.userPic = userPic
    }
    
    // Get Functions
    func getFriendType() -> String { return self.friendType }
    func getUserName() -> String { return self.userName }
    func getUserId() -> String { return self.userId }
    func getUserHandle() -> String { return self.userHandle }
    func getUserPic() -> String { return self.userPic }
    
    // Set Functions
    func setFriendType(friendType: String) { self.friendType = friendType }
    func setUserName(userName: String) { self.userName = userName }
    func setUserId(userId: String) { self.userId = userId }
    func setUserHandle(userHandle: String) { self.userHandle = userHandle }
    func setUserPic(userPic: String) { self.userPic = userPic }
}