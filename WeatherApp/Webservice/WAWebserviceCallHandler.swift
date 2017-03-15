//
//  WAWebserviceCallHandler.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//
// This class is the backbone of the webservice operation and performs the actual webservice call

import UIKit
import Foundation

class WAWebserviceCallHandler: NSObject {
    
    static let shared = WAWebserviceCallHandler()
    weak var vc : UIViewController!
    
    func performRequest(sourceVC: UIViewController, withURL url:URL, completionHandler: @escaping (Data?, Error?)->Void) {
        
        self.vc = sourceVC

        if !self.checkOnlineStatus() {
            WAActivityIndicatorManager.shared.stop()
            return
        }
        
        let request = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: request) { (data, response, error) in
            completionHandler(data,error)
        }
        task.resume()
    }
    
    // Check network connectivity. If not connected, show error
    
    func checkOnlineStatus()->Bool{
        if !Reachability.isConnectedToNetwork() {
            let alert = WAAlertsManager.shared.buildOkAlert(title: ERROR, messsage: NO_NETWORK)
            self.vc?.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
}

extension WAWebserviceCallHandler : URLSessionDelegate {
    
}
