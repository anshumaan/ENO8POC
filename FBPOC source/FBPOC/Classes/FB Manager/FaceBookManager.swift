//
//  FaceBookManager.swift
//  FBPOC
//
//  Created by Anshumaan Singh on 12/07/16.
//  Copyright © 2016 Anshumaan Singh. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import UIKit


protocol FacebookManagerDelegate{
  
    func facebookLoggedIn(accessToken : String)
    func faceboolLoginFailed(error : NSError)
    func facebookLoginCancelled()
    
    func fbUserDetailsFetched(userDict : FBDetailModel)
    func failedToFetchUserDetails(error : NSError)
}

// MARK: BRANCH 123

class FacebookManager: NSObject {
    
    var delegate : FacebookManagerDelegate!
    static let sharedInstance = FacebookManager();

    func logIn() {
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            
            let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
   
            fbLoginManager.logInWithReadPermissions(AppConstants.kReadPermissionArray, fromViewController: nil) { (result, error) in

                if ((error) != nil) {
                
                    self.delegate?.faceboolLoginFailed(error)
                
                }else if let fbLogInResult: FBSDKLoginManagerLoginResult = result{
                    
                    if(fbLogInResult.isCancelled){
                        
                        self.delegate?.facebookLoginCancelled();
                        
                    }else{
                        if (fbLogInResult.grantedPermissions.contains(AppConstants.kEmail)) {
                            self.delegate?.facebookLoggedIn(FBSDKAccessToken.currentAccessToken().tokenString)
                        }
                    }
                    
                }
            }
        } else {
            
          let fbAccessToken = FBSDKAccessToken.currentAccessToken().tokenString
           self.delegate?.facebookLoggedIn(fbAccessToken)
        }
    }
    
    
    
    func getFBUserData() {
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: AppConstants.kUser, parameters: [AppConstants.kField: "\(AppConstants.kId), \(AppConstants.kName), \(AppConstants.kFirstName), \(AppConstants.kLastName), \(AppConstants.kPicture).type(large), \(AppConstants.kEmail), \(AppConstants.kBirthday), \(AppConstants.kTimezone)"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if (error == nil){
                    
                    let model : FBDetailModel =  FBDetailModel.init(responseDict: result as! Dictionary<String, AnyObject>)
                    
                    self.delegate?.fbUserDetailsFetched(model)
                    
                }else{
                    
                    self.delegate?.failedToFetchUserDetails(error)
                }
            })
        }
    }
}
