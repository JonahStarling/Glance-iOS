//
//  TwitterServices.swift
//  Glance
//
//  Created by Jonah Starling on 4/14/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import Foundation
import TwitterKit
import SwiftyJSON
import Firebase

class TwitterServices {
    var accessToken: String
    var userId: String
    var userName: String
    var bestFriends: [Friend]
    
    init() {
        self.accessToken = ""
        self.userId = ""
        self.userName = ""
        self.bestFriends = []
    }
    
    init(accessToken: String, userId: String, userName: String) {
        self.accessToken = accessToken
        self.userId = userId
        self.userName = userName
        self.bestFriends = []
    }
    
    func getBestFriends() {
        var todoEndpoint: String = "https://api.twitter.com/1.1/favorites/user_id="
        todoEndpoint += userId
        todoEndpoint += "/list.json"
        let url = NSURL(string: todoEndpoint)
        let urlRequest = NSURLRequest(URL: url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on TWITTER/1.1/favorites/")
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data from TWITTER/1.1/favorites/")
                return
            }
            // parse the result as JSON, since that's what the API provides
            let json = JSON(data: responseData)
            print(json)
        }
        task.resume()
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
    
    func twitterAccountNotConnected() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.stringForKey("twitterOAuthToken") != nil {
            return false
        }
        return true
    }
    
    func oauthTwitter() {
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if (session != nil) {
                print("signed in as \(session!.userName)");
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(session!.authToken, forKey: "twitterOAuthToken")
                defaults.setObject(session!.userID, forKey: "twitterUserId")
                self.accessToken = session!.authToken
                self.userId = session!.userID
            } else {
                print("error: \(error!.localizedDescription)");
            }
        }
    }
}