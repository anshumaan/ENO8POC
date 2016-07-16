//
//  ViewController.swift
//  FBPOC
//
//  Created by Anshumaan Singh on 12/07/16.
//  Copyright © 2016 Anshumaan Singh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LandingPageController: UIViewController, FacebookManagerDelegate {

 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: FACEBOOK LOGIN ACTION
    @IBAction func fbLogin(sender : UIButton) {
    
        let fbMgr: FacebookManager = FacebookManager.sharedInstance
        fbMgr.delegate = self
        fbMgr.logIn()
    }

//MARK: FACEBOOK OPERATION SUCCESS DELEGATE
    func fbUserDetailsFetched(userDict : FBDetailModel) {
    
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(AppConstants.kController) as? FBDetailsController
        controller?.loadUserDetails(userDict)
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func facebookLoggedIn(accessToken : String) {
        let fbMgr: FacebookManager = FacebookManager.sharedInstance
        fbMgr.getFBUserData()
        
    }
 
//MARK: FACEBOOK OPERATION FAILURE DELEGATE
    func faceboolLoginFailed(error : NSError) {
        
        displayErrorAlert(error.localizedDescription, controller: self)
    }
    
    func failedToFetchUserDetails(error: NSError) {
        
        displayErrorAlert(error.localizedDescription, controller: self)
    }
    
    func facebookLoginCancelled(){
    
        displayErrorAlert( AppConstants.kUserCancelMsg, controller: self)
    }
    


}

