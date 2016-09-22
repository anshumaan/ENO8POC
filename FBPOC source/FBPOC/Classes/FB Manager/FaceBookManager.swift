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
  
    func facebookLoggedIn(_ accessToken : String)
    func faceboolLoginFailed(_ error : NSError)
    func facebookLoginCancelled()
    
    func fbUserDetailsFetched(_ userDict : FBDetailModel)
    func failedToFetchUserDetails(_ error : NSError)
}

class FacebookManager: NSObject {
    
    var delegate : FacebookManagerDelegate!
    static let sharedInstance = FacebookManager();

    func logIn() {
        
        if (FBSDKAccessToken.current() == nil) {
            
            let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
   
            fbLoginManager.logIn(withReadPermissions: AppConstants.kReadPermissionArray, from: nil) { (result, error) in

                if ((error) != nil) {
                
                    self.delegate?.faceboolLoginFailed(error as! NSError)
                
                }else if let fbLogInResult: FBSDKLoginManagerLoginResult = result{
                    
                    if(fbLogInResult.isCancelled){
                        
                        self.delegate?.facebookLoginCancelled();
                        
                    }else{
                        if (fbLogInResult.grantedPermissions.contains(AppConstants.kEmail)) {
                            self.delegate?.facebookLoggedIn(FBSDKAccessToken.current().tokenString)
                        }
                    }
                    
                }
            }
        } else {
            
          let fbAccessToken = FBSDKAccessToken.current().tokenString
           self.delegate?.facebookLoggedIn(fbAccessToken!)
        }
    }
    
    
    
    func getFBUserData() {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: AppConstants.kUser, parameters: [AppConstants.kField: "\(AppConstants.kId), \(AppConstants.kName), \(AppConstants.kFirstName), \(AppConstants.kLastName), \(AppConstants.kPicture).type(large), \(AppConstants.kEmail), \(AppConstants.kBirthday), \(AppConstants.kTimezone)"]).start(completionHandler: { (connection, result, error) -> Void in
                
                if (error == nil){
                    
                    let model : FBDetailModel =  FBDetailModel.init(responseDict: result as! Dictionary<String, AnyObject>)
                    
                    self.delegate?.fbUserDetailsFetched(model)
                    
                }else{
                    
                    self.delegate?.failedToFetchUserDetails(error as! NSError)
                }
            })
        }
    }
}
