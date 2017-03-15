//
//  WAResponseParser.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//
//  This class is responsible for parsing the webservice responses
//  Currently responses could be a json or an image file

import UIKit

// Empty protocol to group different types of responses from a webservice call
// e.g. json, image etc.

protocol ParsedObject {}

class WAResponseParser {
    
    static let shared = WAResponseParser()
    
    func parseResponse(data:Data, service: WAWebServiceManager.Service)->ParsedObject?{
        
        switch service {
        case .conditions:
            var dict : [String:Any]?
            do{
                dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            }catch{
                
            }
            return self.parseCityWeatherConditionsResponse(responseDict: dict ?? [:])
        case .icon:
            return self.getImage(fromData: data)
        }
    }
    
    // Parse json for the weather conditions of a city and return a WAWeatherDataObject
    
    private func parseCityWeatherConditionsResponse(responseDict:[String:Any])->WAWeatherDataObject?{
        var temp, pressure, humidity, windSpeed, windDirection : Float
        var cityName, descr : String
        var icons = [String]()
        var sunrise, sunset : Int
        
        temp = -999
        pressure = -999
        humidity = -999
        windSpeed = -999
        windDirection = -999
        descr = ""
        cityName = ""
        sunrise = -999
        sunset = -999
        
        if let main = responseDict["main"] as? [String:Float] {
            temp = main["temp"] ?? -999
            temp != -999 ? (temp = temp * 9/5 - 459.67):()
            pressure = main["pressure"] ?? -999
            humidity = main["humidity"] ?? -999
        }
        
        if let wind = responseDict["wind"] as? [String:Float] {
            windSpeed = wind["speed"] ?? -999
            windDirection = wind["deg"] ?? -999
        }
        
        if let sys = responseDict["sys"] as? [String:Any] {
            sunrise = (sys["sunrise"] as? Int) ?? -999
            sunset = (sys["sunset"] as? Int) ?? -999
            
        }
        
        if let weather = responseDict["weather"] as? [[String:Any]] {
            var desc = [String]()
            let _ = weather.map({parm in
                desc.append((parm["main"] as? String) ?? "")
                if let icon = parm["icon"] as? String {
                    icons.append(icon)
                }
                
                }
            )
            descr = desc.joined(separator: ", ")
        }
        
        cityName = (responseDict["name"] as? String) ?? ""
        return WAWeatherDataObject(cityName: cityName, descr: descr, icons: icons, temp: temp, pressure: pressure, humidity: humidity, windSpeed: windSpeed, windDirection: windDirection, sunrise: sunrise, sunset: sunset)
    }
    
    // Get UIImage from response data
    
    private func getImage(fromData data:Data)->UIImage?{
        return UIImage(data: data)
    }
}
