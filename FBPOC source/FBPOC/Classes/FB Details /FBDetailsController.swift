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
    
    
    func loadUserDetails(_ userDetail : FBDetailModel) {
        details = userDetail
    }
    
    override func viewDidLoad() {
        
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            let strPictureURL: String = (self.details?.url)!
            let data = try? Data(contentsOf: URL.init(string: strPictureURL)!)
            
            DispatchQueue.main.async(execute: { () -> Void in
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
        
        let tZone: TimeZone = TimeZone.autoupdatingCurrent
        let tzName: String = tZone.localizedName(for: TimeZone.standard, locale: Locale.autoupdatingCurrent)!
        timeZone!.text = tzName
        
    }
    
    func calcAge(_ birthday:String) -> Int{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = AppConstants.kDateFormat
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        let now: Date! = Date()
        let calcAge = calendar.dateComponents(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
}













