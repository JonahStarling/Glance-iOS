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
                                      "bestFriendName": item["user"]["full_name"].stringValue,
                                      "bestFriendHandle": item["user"]["username"].stringValue,
                                      "bestFriendProfilePicture": item["user"]["profile_picture"].stringValue,
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
    
    func getRelevantPosts() {
        loadBestFriendsFromDB()
        for bestFriend in bestFriends {
            var todoEndpoint: String = "https://api.instagram.com/v1/users/"
            todoEndpoint += bestFriend.getUserId()
            todoEndpoint += "/media/recent/?access_token="
            todoEndpoint += accessToken
            let url = NSURL(string: todoEndpoint)
            let urlRequest = NSURLRequest(URL: url!)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            let task = session.dataTaskWithRequest(urlRequest) {
                (data, response, error) in
                // check for any errors
                guard error == nil else {
                    print("error calling GET on INSTAGRAM/v1/users/self/feed/")
                    print(error)
                    return
                }
                // make sure we got data
                guard let responseData = data else {
                    print("Error: did not receive data from INSTAGRAM/v1/users/self/feed/")
                    return
                }
                // parse the result as JSON, since that's what the API provides
                let json = JSON(data: responseData)
                print(json)
            }
            task.resume()
        }
    }
    
    func loadBestFriendsFromDB() {
        var bestFriends: [Friend] = []
        let ref = Firebase(url: "https://theglance.firebaseio.com/bestfriendsinstagram/"+self.userId)
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                print("Instagram Call Load Best Friends From DB returned nothing!")
            } else {
                let enumerator = snapshot.children
                while let friend = enumerator.nextObject() as? FDataSnapshot {
                    let userName = friend.value["bestFriendName"] as? String
                    let userId = friend.value["bestFriendId"] as? String
                    let userHandle = friend.value["bestFriendHandle"] as? String
                    let userPic = friend.value["bestFriendProfilePicture"] as? String
                    bestFriends.append(Friend(friendType: "Instagram", userName: userName!, userId: userId!, userHandle: userHandle!, userPic: userPic!))
                }
            }
            // TODO: Send bestFriends array to the adapter to load into the Account Management View
            self.bestFriends = bestFriends
        })
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