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
        
    }
    
}

extension WeatherIcon {
    var image: UIImage {
        return UIImage(named: rawValue)!
    }
    
}