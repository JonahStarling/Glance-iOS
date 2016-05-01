//
//  FriendStore.swift
//  Glance
//
//  Created by Jonah Starling on 4/30/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import UIKit

class FriendStore {
    static let sharedInstance:FriendStore = FriendStore()
    
    var allFriends = [Friend]()
    
    func addFriend(newFriend: Friend) {
        allFriends.append(newFriend)
    }
    
    func addMultipleFriends(newFriends: [Friend]) {
        allFriends += newFriends
    }
    
    func replaceAllFriends(newFriends: [Friend]) {
        allFriends.removeAll()
        allFriends = newFriends
    }
    
    func removeAllFriends() {
        allFriends.removeAll()
    }
    
    func getCount() -> Int {
        return allFriends.count
    }
    
    func getFriendAt(index: Int) -> Friend {
        return allFriends[index]
    }
    
}
