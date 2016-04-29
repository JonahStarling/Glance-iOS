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

    let twitterService = TwitterServices()
    let instagramService = InstagramServices()
    let facebookService = FacebookServices()
    
    @IBOutlet var twitterButton: UIButton!
    @IBOutlet var instagramButton: UIButton!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var googlePlusButton: UIButton!
    @IBOutlet var foursquareButton: UIButton!
    @IBOutlet var pinterestButton: UIButton!
    @IBOutlet var myspaceButton: UIButton!
    @IBOutlet var redditButton: UIButton!
    @IBOutlet var tumblrButton: UIButton!
    @IBOutlet var linkedInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAccountButtonStatus()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateAccountButtonStatus() {
        updateTwitterAccountButtonStatus()
        updateInstagramAccountButtonStatus()
        updateFacebookAccountButtonStatus()
    }
    
    // Twitter
    @IBAction func connectTwitterAccount(sender: UIButton) {
        if (self.twitterService.twitterAccountNotConnected()) {
            self.twitterService.oauthTwitter()
            updateTwitterAccountButtonStatus()
        } else {
            //Send user to account management page for Twitter
            performSegueWithIdentifier("AccountManagementSegue", sender: self)
        }
    }
    
    func updateTwitterAccountButtonStatus() {
        if (!self.twitterService.twitterAccountNotConnected()) {
            twitterButton.setImage(UIImage(named: "TwitterFilledBlue"), forState: .Normal)
        } else {
            twitterButton.setImage(UIImage(named: "TwitterFilledGrey"), forState: .Normal)
        }
    }
    
    // Instagram
    @IBAction func connectInstagramAccount(sender: UIButton) {
        if (self.instagramService.instagramAccountNotConnected()) {
            self.instagramService.oauthInstagram(self)
            updateInstagramAccountButtonStatus()
        } else {
            self.instagramService.getBestFriends()
            //Send user to account management page for Instagram
            performSegueWithIdentifier("AccountManagementSegue", sender: self)
        }
    }
    
    func updateInstagramAccountButtonStatus() {
        if (!self.instagramService.instagramAccountNotConnected()) {
            instagramButton.setImage(UIImage(named: "InstagramFilledBlue"), forState: .Normal)
        } else {
            instagramButton.setImage(UIImage(named: "InstagramFilledGrey"), forState: .Normal)
        }
    }
    
    // Facebook
    @IBAction func connectFacebookAccount(sender: UIButton) {
        if (self.facebookService.facebookAccountNotConnected()) {
            self.facebookService.oauthFacebook()
            updateFacebookAccountButtonStatus()
        } else {
            //Send user to account management page for Facebook
        }
    }
    
    func updateFacebookAccountButtonStatus() {
        if (!self.facebookService.facebookAccountNotConnected()) {
            facebookButton.setImage(UIImage(named: "FacebookFilledBlue"), forState: .Normal)
        } else {
            facebookButton.setImage(UIImage(named: "FacebookFilledGrey"), forState: .Normal)
        }
    }
}

