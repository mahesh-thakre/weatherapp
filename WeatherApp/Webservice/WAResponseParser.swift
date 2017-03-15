//
//  WAResponseParser.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//

import UIKit

protocol ParsedObject {}

class WAResponseParser {
    
    static let shared = WAResponseParser()
    
    func parseResponse(data:Data, service: WAWebServiceManager.Service)->ParsedObject{
        var dict : [String:Any]?
        do{
            dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        }catch{
            
        }
        
        switch service {
        case .city:
            return self.parseCityWeatherConditionsResponse(responseDict: dict ?? [:])
        }
    }
    
    
    private func parseCityWeatherConditionsResponse(responseDict:[String:Any])->WAWeatherDataObject{
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
            descr = ""
            let _ = weather.map({parm in
                descr += "," + ((parm["main"] as? String) ?? "")
                if let icon = parm["icon"] as? String {
                    icons.append(icon)
                }
                
                }
            )
        }
        
        cityName = (responseDict["name"] as? String) ?? ""
        return WAWeatherDataObject(cityName: cityName, descr: descr, icons: icons, temp: temp, pressure: pressure, humidity: humidity, windSpeed: windSpeed, windDirection: windDirection, sunrise: sunrise, sunset: sunset)
    }
}