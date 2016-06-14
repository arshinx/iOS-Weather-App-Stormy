//
//  ForecastClient.swift
//  Stormy
//
//  Created by Arshin Jain on 6/14/16.
//  Copyright © 2016 Arshin Jain. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

// Make it easy to interact with ForecastClient
enum Forecast: Endpoint {
    case Current(token: String, coordinate: Coordinate)
    
    var baseURL: NSURL {
        return NSURL(string: "https://api.forecast.io")!
    }
    
    var path: String {
        switch self {
        case .Current(let token, let Coordinate):
            return "/forecast/\(token)/\(Coordinate.latitude),\(Coordinate.longitude)"
        }
    }
    
    var request: NSURLRequest {
        let url = NSURL(string: path, relativeToURL: baseURL)!
        return NSURLRequest(URL: url)
    }
}

final class ForecastAPIClient: APIClient {
   
    let configuration: NSURLSessionConfiguration
    
    lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.configuration)
    }()
    
    private let token: String
    
    init(config: NSURLSessionConfiguration, APIKey: String) {
        self.configuration = config
        self.token = APIKey
    }
    
    convenience init(APIKey: String) {
        self.init(config: NSURLSessionConfiguration.defaultSessionConfiguration(), APIKey: APIKey)
    }
    
    func fetchCurrentWeather(coordinate: Coordinate, completion: APIResult<CurrentWeather> -> Void) {
        
        let request = Forecast.Current(token: self.token, coordinate: coordinate).request
        
        fetch(request, parse: { (json) -> CurrentWeather? in
            // Parse from JSON response to weather
            
            if let currentWeatherDictionary = json["currently"] as? [String: AnyObject] {
                return CurrentWeather(JSON: currentWeatherDictionary)
            }
            
            }, completion: <#T##APIResult<T> -> Void#>)
    }
    
}


extension CurrentWeather: JSONDecodable {
    
    
    init?(JSON: [String : AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
        humidity                    = JSON["humidity"] as? Double,
        precipitationProbability    = JSON["precipitationProbability"] as? Double,
        summary                     = JSON["summary"] as? String,
            iconString = JSON["icon"] as? String else {
                return nil
        }
        
        let icon = WeatherIcon(rawValue: iconString).image
        
        self.temperature                = temperature
        self.humidity                   = humidity
        self.precipitationProbability   = precipitationProbability
        self.summary                    = summary
        self.icon                       = icon
        
        
    }
    
}









