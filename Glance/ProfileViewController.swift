//
//  SecondViewController.swift
//  Glance
//
//  Created by Jonah Starling on 1/9/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import UIKit
import OAuthSwift

class SecondViewController: UIViewController {

    @IBOutlet var accountNotAddedView: UIView!
    @IBOutlet var accountAddedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var accountAdded: Bool
        let accountAdded = false
        setAccountManagementView(accountAdded)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAccountManagementView(accountAdded: Bool) {
        accountAddedView.hidden = !accountAdded
        accountNotAddedView.hidden = accountAdded
    }
    
    @IBAction func connectInstagramAccount(sender: UIButton) {
        oauthInstagram()
    }
    
    func oauthInstagram() {
        let oauthswift = OAuth2Swift(
            consumerKey:    "9c239d8d8a92482caa7d11b639f85600",
            consumerSecret: "b4ebc73b26724c779b74b50303912683",
            authorizeUrl:   "https://api.instagram.com/oauth/authorize",
            responseType:   "token"
        )
        oauthswift.authorize_url_handler = SafariURLHandler(viewController: self)
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

