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
    let BASE_URL = "http://api.openweathermap.org/"
    static let shared = WAWebServiceManager()
    
    // This enum determines the endpoint value
    // for each webservice call
    
    enum Service : String {
        case conditions = "data/2.5/weather"
        case icon = "img/w"
    }
    
    // Method to access weather conditions for a given city
    func fetchWeatherConditions(sourceVC:UIViewController, city:String, completionHandler: @escaping (WAWeatherDataObject)->Void) {
        guard let city = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: BASE_URL + Service.conditions.rawValue + "?appid=" + API_KEY + "&q=" + city) else {
            WAWebServiceErrorHandler.shared.handleError(presentedVC: sourceVC, title:ERROR, message:INVALID_URL)
            return
        }
        WAWebserviceCallHandler.shared.performRequest(sourceVC:sourceVC, withURL: url) { (data, error) in
            if let e = error {
                WAWebServiceErrorHandler.shared.handleError(presentedVC: sourceVC, title:ERROR, message:e.localizedDescription)
                return
            }
            if let d = data {
                if let object =  WAResponseParser.shared.parseResponse(data: d, service: WAWebServiceManager.Service.conditions) as? WAWeatherDataObject {
                    completionHandler(object)
                }
            }
        }
    }
    
    func fetchImageIcon(sourceVC: UIViewController, imageName: String,completionHandler: @escaping (UIImage)->Void ){
        guard let url = URL(string: BASE_URL + Service.icon.rawValue + "/" + imageName) else {
            WAWebServiceErrorHandler.shared.handleError(presentedVC: sourceVC, title:ERROR, message:INVALID_URL)
            return
        }
        
        WAWebserviceCallHandler.shared.performRequest(sourceVC:sourceVC, withURL: url) { (data, error) in
            if let e = error {
                WAWebServiceErrorHandler.shared.handleError(presentedVC: sourceVC, title:ERROR, message:e.localizedDescription)
                return
            }
            if let d = data {
                if let image =  WAResponseParser.shared.parseResponse(data: d, service: WAWebServiceManager.Service.icon) as? UIImage {
                    completionHandler(image)
                }
            }
        }

    }

}
