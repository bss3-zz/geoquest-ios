//
//  ViewController.swift
//  Geoquest
//
//  Created by Bruno Soares da Silva on 6/4/16.
//  Copyright © 2016 Bruno Soares da Silva. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    
    @IBOutlet weak var login: FBSDKLoginButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFacebook()
        
        if(FBSDKAccessToken.currentAccessToken() != nil){
            print("User already logged in")
            loadUserInfo()
        }else{
            print("User must login first")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureFacebook() {
        login.readPermissions = ["public_profile", "email", "user_friends"];
        login.delegate = self
    }

    func loadUserInfo(){
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "first_name, last_name, picture.type(large)"]).startWithCompletionHandler{
            (connection, result, error) -> Void in
            let first_name: String = (result.objectForKey("first_name") as? String)!
            let last_name: String = (result.objectForKey("last_name") as? String)!
            let profile_picture = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            
            self.profileName.text = "\(first_name) \(last_name)"
            self.profilePicture.image = UIImage(data: NSData(contentsOfURL: NSURL(string: profile_picture)!)!)
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil) {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // Navigate to other view
        }
        loadUserInfo()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        self.profileName.text = ""
        self.profilePicture.image = nil
    }
}

