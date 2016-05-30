//
//  WeatherIcon.swift
//  Stormy
//
//  Created by Arshin Jain on 5/30/16.
//  Copyright © 2016 Arshin Jain. All rights reserved.
//

import Foundation
import UIKit

enum WeatherIcon: String {
    
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    case UnexpectedType = "default" // Added to prevent unexpected results
    
    init(rawValue: String) {
        switch rawValue {
        case "clear-day": self = .ClearDay
        case "clear-night": self = .ClearNight
        case "rain": self = .Rain
        case "snow": self = .Snow
        case "sleet": self = .Sleet
        case "wind": self = .Wind
        case "fog": self = .Fog
        case "cloudy": self = .Cloudy
        case "partly-cloudy-day": self = .PartlyCloudyDay
        case "partly-cloudy-night": self = .PartlyCloudyNight
        default: self = .UnexpectedType
        }
    }
    
}

extension WeatherIcon {
    var image: UIImage {
        return UIImage(named: rawValue)!
    }
    
}