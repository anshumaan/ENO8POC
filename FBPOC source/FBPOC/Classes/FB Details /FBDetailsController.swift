//
//  FBDetailsController.swift
//  FBPOC
//
//  Created by rohit shac on 13/07/16.
//  Copyright © 2016 Anshumaan Singh. All rights reserved.
//

import Foundation
import UIKit


class FBDetailsController: UIViewController {
    
    @IBOutlet weak var fbPic      : UIImageView?
    @IBOutlet weak var fb_email   : UILabel?
    @IBOutlet weak var first_name : UILabel?
    @IBOutlet weak var last_name  : UILabel?
    @IBOutlet weak var timeZone   : UILabel?
    @IBOutlet weak var user_age   : UILabel?
    var details: FBDetailModel?
    
    
    func loadUserDetails(userDetail : FBDetailModel) {
        details = userDetail
    }
    
    override func viewDidLoad() {
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            
            let strPictureURL: String = (self.details?.url)!
            let data = NSData(contentsOfURL : NSURL.init(string: strPictureURL)!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.fbPic?.image = UIImage(data : data!)
            })
        })
    
        fb_email?.text = details?.emailId
        first_name?.text = details?.firstName
        last_name?.text  = details?.lastName
        
        if let birthday = details?.birthday{
            let userAge = calcAge(birthday);
            user_age?.text   = "\(userAge)" + AppConstants.kAgeSuffix
        }
        
        let tZone: NSTimeZone = NSTimeZone.localTimeZone()
        let tzName: String = tZone.localizedName(NSTimeZoneNameStyle.Standard, locale: NSLocale.autoupdatingCurrentLocale())!
        timeZone!.text = tzName
        
    }
    
    func calcAge(birthday:String) -> Int{
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = AppConstants.kDateFormat
        let birthdayDate = dateFormater.dateFromString(birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let now: NSDate! = NSDate()
        let calcAge = calendar.components(.Year, fromDate: birthdayDate!, toDate: now, options: [])
        let age = calcAge.year
        return age
    }
}













