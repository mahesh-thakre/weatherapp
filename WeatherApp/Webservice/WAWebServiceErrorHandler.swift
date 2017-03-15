//
//  WAWebServiceErrorHandler.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//

import UIKit

class WAWebServiceErrorHandler: NSObject {

    static let shared = WAWebServiceErrorHandler()
    
    func handleError(presentedVC: UIViewController, title:String, message:String) {
        WAActivityIndicatorManager.shared.stop()
        let alert = WAAlertsManager.shared.buildOkAlert(title: title, messsage: message)
        presentedVC.present(alert, animated: true, completion: nil)
        return
    }
}
