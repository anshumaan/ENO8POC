//
//  FBDetailModel.swift
//  FBPOC
//
//  Created by Anshumaan on 14/07/16.
//  Copyright © 2016 Anshumaan Singh. All rights reserved.
//

import Foundation


protocol ParsableProtocol {
    
    init(responseDict :Dictionary<String, AnyObject>);
}

class FBDetailModel: ParsableProtocol {
    
    let emailId  : String!
    let firstName: String?
    let lastName : String?
    let timeZone : String?
    let url      : String?
    let birthday : String?
    
    required init(responseDict: Dictionary<String, AnyObject>) {
       
        self.emailId   = responseDict[AppConstants.kEmail] as? String
        self.firstName = responseDict[AppConstants.kFirstName] as? String
        self.lastName  = responseDict[AppConstants.kLastName] as? String
        self.timeZone  = responseDict[AppConstants.kTimezone] as? String
        self.birthday  = responseDict[AppConstants.kBirthday] as? String
        
        self.url = responseDict[AppConstants.kPicture]![AppConstants.kData]!![AppConstants.kUrl] as? String
    }

}
