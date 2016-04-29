//
//  InstagramServices.swift
//  Glance
//
//  Created by Jonah Starling on 4/14/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import Foundation
import OAuthSwift
import SwiftyJSON
import Firebase

class InstagramServices {
    var accessToken: String
    var userId: String
    var userName: String
    
    init() {
        self.accessToken = ""
        self.userId = ""
        self.userName = ""
    }
    
    init(accessToken: String, userId: String, userName: String) {
        self.accessToken = accessToken
        self.userId = userId
        self.userName = userName
    }
    
    func getBestFriends() {
        var todoEndpoint: String = "https://api.instagram.com/v1/users/self/media/liked/?access_token="
        todoEndpoint += accessToken
        let url = NSURL(string: todoEndpoint)
        let urlRequest = NSURLRequest(URL: url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on INSTAGRAM/v1/users/self/media/liked/")
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data from INSTAGRAM/v1/users/self/media/liked/")
                return
            }
            // parse the result as JSON, since that's what the API provides
            let json = JSON(data: responseData)
            var bestFriends = [[String:String]]()
            if let items = json["data"].array {
                for item in items {
                    var foundInArray: Bool = false
                    let bestFriend = ["userId": self.userId,
                                      "userName": self.userName,
                                      "bestFriendId": item["user"]["id"].stringValue,
                                      "bestFriendName": item["user"]["username"].stringValue,
                                      "bestFriendScore": "1"]
                    var i = 0
                    for var friend in bestFriends {
                        let friendId = friend["bestFriendId"]
                        if (friendId == item["user"]["id"].stringValue) {
                            var score = Int(friend["bestFriendScore"]!)
                            score = score! + 1
                            bestFriends[i].updateValue(String(score!), forKey: "bestFriendScore")
                            foundInArray = true
                        }
                        i+=1
                    }
                    if (foundInArray == false) {
                        bestFriends.append(bestFriend)
                    }
                }
            }
            // TODO: Add code to filter the bestFriends Array down to the top ten
            self.saveBestFriendsToDB(bestFriends)
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
    
    func saveBestFriendsToDB(bestFriends: [[String : String]]) {
        for bestFriend in bestFriends {
            let ref = Firebase(url: "https://theglance.firebaseio.com/bestfriendsinstagram/"+self.userId)
            ref.childByAppendingPath(bestFriend["bestFriendId"]).setValue(bestFriend)
        }
    }
    
    func getUsersInfo() {
        var todoEndpoint: String = "https://api.instagram.com/v1/users/self/?access_token="
        todoEndpoint += accessToken
        let url = NSURL(string: todoEndpoint)
        let urlRequest = NSURLRequest(URL: url!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on INSTAGRAM/v1/users/self/")
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data from INSTAGRAM/v1/users/self/")
                return
            }
            // parse the result as JSON, since that's what the API provides
            let json = JSON(data: responseData)
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(json["data"]["id"].stringValue, forKey: "instagramUserId")
            defaults.setObject(json["data"]["username"].stringValue, forKey: "instagramUserName")
            self.userId = json["data"]["id"].stringValue
            self.userName = json["data"]["username"].stringValue
        }
        task.resume()
    }
    
    func instagramAccountNotConnected() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.stringForKey("instagramOAuthToken") != nil {
            self.accessToken = defaults.stringForKey("instagramOAuthToken")!
            self.userId = defaults.stringForKey("instagramUserId")!
            self.userName = defaults.stringForKey("instagramUserName")!
            return false
        }
        return true
    }
    
    func oauthInstagram(view: UIViewController) {
        let oauthswift = OAuth2Swift(
            consumerKey:    "9c239d8d8a92482caa7d11b639f85600",
            consumerSecret: "b4ebc73b26724c779b74b50303912683",
            authorizeUrl:   "https://api.instagram.com/oauth/authorize",
            responseType:   "token"
        )
        oauthswift.authorize_url_handler = SafariURLHandler(viewController: view)
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "Glance://oauth-callback/instagram")!,
            scope: "basic+likes+comments+public_content", state:"INSTAGRAM",
            success: { credential, response, parameters in
                //STORE OAUTH TOKEN ON THE PHONE
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(credential.oauth_token, forKey: "instagramOAuthToken")
                self.accessToken = credential.oauth_token
                self.getUsersInfo()
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
}