//
//  ProfileViewController.swift
//  Glance
//
//  Created by Jonah Starling on 1/9/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import UIKit
import OAuthSwift
import TwitterKit

class ProfileViewController: UIViewController {

    @IBOutlet var accountNotAddedView: UIView!
    @IBOutlet var accountAddedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var accountAdded: Bool
        let accountAdded = false
        setAccountManagementView(accountAdded)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .Black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAccountManagementView(accountAdded: Bool) {
        accountAddedView.hidden = !accountAdded
        accountNotAddedView.hidden = accountAdded
    }
    
    @IBAction func connectFacebookAccount(sender: UIButton) {
        oauthFacebook()
    }
    
    func oauthFacebook() {
        //Add OAuth2.0 Code for Facebook
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
    
    @IBAction func connectTwitterAccount(sender: UIButton) {
        oauthTwitter()
    }
    
    func oauthTwitter() {
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if (session != nil) {
                print("signed in as \(session!.userName)");
            } else {
                print("error: \(error!.localizedDescription)");
            }
        }
    }
}

