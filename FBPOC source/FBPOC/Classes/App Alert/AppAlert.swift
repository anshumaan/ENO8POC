//
//  AppAlert.swift
//  FBPOC
//
//  Created by Anshumaan Singh on 16/07/16.
//  Copyright © 2016 Anshumaan Singh. All rights reserved.
//

import Foundation
import UIKit


func displaySuccessAlert(message:String, controller: UIViewController){
    
    displayAlert("Success", messageStr: message, controller: controller);
}


func displayErrorAlert( message:String, controller: UIViewController){
 
    displayAlert("Error", messageStr: message, controller: controller);
}

func displayAlert(titleStr: String, messageStr:String , controller: UIViewController){
    
    let alertController = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .Alert)
    
    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(defaultAction)
    
    controller.presentViewController(alertController, animated: true, completion: nil)
}