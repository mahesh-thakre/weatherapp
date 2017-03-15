//
//  WAWeatherDataObject.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//  
// This struct represents a snapshot of weather condition parameter values

import UIKit

struct WAWeatherDataObject : ParsedObject {
    var cityName : String
    var descr : String
    var icons : [String]
    var temp : Float
    var pressure : Float
    var humidity : Float
    var windSpeed : Float
    var windDirection : Float
    var sunrise : Int
    var sunset : Int
}
