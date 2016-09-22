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
    @IBAction func fbLogin(_ sender : UIButton) {
    
        let fbMgr: FacebookManager = FacebookManager.sharedInstance
        fbMgr.delegate = self
        fbMgr.logIn()
    }

//MARK: FACEBOOK OPERATION SUCCESS DELEGATE
    func fbUserDetailsFetched(_ userDict : FBDetailModel) {
    
        let controller = self.storyboard?.instantiateViewController(withIdentifier: AppConstants.kController) as? FBDetailsController
        controller?.loadUserDetails(userDict)
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func facebookLoggedIn(_ accessToken : String) {
        let fbMgr: FacebookManager = FacebookManager.sharedInstance
        fbMgr.getFBUserData()
        
    }
 
//MARK: FACEBOOK OPERATION FAILURE DELEGATE
    func faceboolLoginFailed(_ error : NSError) {
        
        displayErrorAlert(error.localizedDescription, controller: self)
    }
    
    func failedToFetchUserDetails(_ error: NSError) {
        
        displayErrorAlert(error.localizedDescription, controller: self)
    }
    
    func facebookLoginCancelled(){
    
        displayErrorAlert( AppConstants.kUserCancelMsg, controller: self)
    }
    


}

