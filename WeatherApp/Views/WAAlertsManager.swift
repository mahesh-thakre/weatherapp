//
//  WAAlertsManager.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//
// This singleton class manages creation of alerts to be displayed 
// in case of an error condition

import UIKit

class WAAlertsManager {
    
    static let shared = WAAlertsManager()
    
    func buildOkAlert(title:String,messsage:String,okAction: ((UIAlertAction)->Void)? = nil)->UIAlertController{
        let alert : UIAlertController = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (action) -> Void in
            okAction?(action)
        }
        
        alert.addAction(okAction)
        return alert
    }
    
    func buildDefaultAlert(title:String,messsage:String,okAction:((UIAlertAction)->Void)? = nil,cancelAction:((UIAlertAction)->Void)? = nil)->UIAlertController{
        let alert : UIAlertController = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (action) -> Void in
            okAction?(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (action) -> Void in
            cancelAction?(action)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        return alert
    }
}

