//
//  InstagramServices.swift
//  Glance
//
//  Created by Jonah Starling on 4/14/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import Foundation
import OAuthSwift

class InstagramServices {
    var accessToken: String
    
    init() {
        self.accessToken = ""
    }
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func getBestFriends() {
        //Get best friends
        //
        //Loop through the last 100 posts
        //Get a count of likes per user
        //Get top ten
        //Create Friend Objects for them
        //Load them to the firebase database
        //
        //API CALL: /users/self/media/liked
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
    
    func instagramAccountNotConnected() -> Bool {
        //Add code to check firebase to see if connected yet
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
            scope: "likes+comments", state:"INSTAGRAM",
            success: { credential, response, parameters in
                print(credential.oauth_token)
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
}