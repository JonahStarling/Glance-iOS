//
//  ProfileViewController.swift
//  Glance
//
//  Created by Jonah Starling on 1/9/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectFacebookAccount(sender: UIButton) {
        let facebookService = FacebookServices()
        if (facebookService.facebookAccountNotConnected()) {
            facebookService.oauthFacebook()
        } else {
            //Send user to account management page for Facebook
        }
    }
    
    @IBAction func connectInstagramAccount(sender: UIButton) {
        let instagramService = InstagramServices()
        if (instagramService.instagramAccountNotConnected()) {
            instagramService.oauthInstagram(self)
        } else {
            instagramService.getBestFriends()
            //Send user to account management page for Instagram
            performSegueWithIdentifier("AccountManagementSegue", sender: self)
        }
    }
    
    @IBAction func connectTwitterAccount(sender: UIButton) {
        let twitterService = TwitterServices()
        if (twitterService.twitterAccountNotConnected()) {
            twitterService.oauthTwitter()
        } else {
            //Send user to account management page for Twitter
            performSegueWithIdentifier("AccountManagementSegue", sender: self)
        }
    }
}

