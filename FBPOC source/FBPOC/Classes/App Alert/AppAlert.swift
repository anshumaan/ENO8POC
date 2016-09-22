//
//  AppAlert.swift
//  FBPOC
//
//  Created by Anshumaan Singh on 16/07/16.
//  Copyright © 2016 Anshumaan Singh. All rights reserved.
//

import Foundation
import UIKit


func displaySuccessAlert(_ message:String, controller: UIViewController){
    
    displayAlert("Success", messageStr: message, controller: controller);
}


func displayErrorAlert( _ message:String, controller: UIViewController){
 
    displayAlert("Error", messageStr: message, controller: controller);
}

func displayAlert(_ titleStr: String, messageStr:String , controller: UIViewController){
    
    let alertController = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
    
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    
    controller.present(alertController, animated: true, completion: nil)
}
