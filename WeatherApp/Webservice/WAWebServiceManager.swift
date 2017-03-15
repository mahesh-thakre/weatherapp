//
//  WAWebServiceManager.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//
// This class provides a wrapper to the webservice handler which makes the actual webservice calls

import UIKit
import Foundation

class WAWebServiceManager: NSObject {
    let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?appid=" + API_KEY
    static let shared = WAWebServiceManager()
    
    // This enum determines the endpoint value
    // for each webservice call
    
    enum Service : String {
        case city = "&q="
    }
    
    
    func fetchWeatherConditions(sourceVC:UIViewController, city:String, service: Service, completionHandler: @escaping (WAWeatherDataObject)->Void) {
        guard let url = URL(string: BASE_URL + service.rawValue + city) else {
            let alert = WAAlertsManager.shared.buildOkAlert(title: ERROR, messsage: INVALID_URL)
            sourceVC.present(alert, animated: true, completion: nil)
            return
        }
        WAWebserviceCallHandler.shared.performRequest(sourceVC:sourceVC, withURL: url) { (data, error) in
            if let e = error {
                WAWebServiceErrorHandler.shared.handleError(error: e)
                return
            }
            if let d = data {
                if let object =  WAResponseParser.shared.parseResponse(data: d, service: WAWebServiceManager.Service.city) as? WAWeatherDataObject {
                    completionHandler(object)
                }
            }
        }
    }
}
