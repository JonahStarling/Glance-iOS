//
//  TwitterServices.swift
//  Glance
//
//  Created by Jonah Starling on 4/14/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import Foundation

class TwitterServices {
    var accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func getBestFriends() {
        //Get best friends
        //
        //Loop through the last 500 posts
        //Get a count of likes per user
        //Get top ten
        //Create Friend Objects for them
        //Load them to the firebase database
    }
    
    func getRelevantPosts(nextPage: String) -> String {
        //Get relevant posts
        //
        //If nextPage is not empty then
        //Get the page using the nextPage String
        //Otherwise get the most recent page
        //Go through posts and if post is by a best friend then create a post object
        //Add that post to the home page
        return ""
    }
    
    func loadBestFriendsFromDB() {
        //Load the best friends list from the firebase database
        //
        //Pretty self explanatory
    }
    
    func saveBestFriendsToDB() {
        //Save the best friends list to the firebase database
        //
        //Pretty self explanatory
    }
}