//
//  ViewController.swift
//  Stormy
//
//

import UIKit

extension CurrentWeather {
    
    var temperatureString: String {
        return "\(Int(temperature))º"
    }
    
    var humidityString: String {
        let percentageValue = Int(humidity * 100)
        return "\(percentageValue)%"
    }
    
    var precipitationProbabilityString: String {
        let percentageValue = Int(precipitationProbability * 100)
        return "\(percentageValue)%"
    }
    
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let forecastAPIKey = "01ba71cbdee446dda597b43faeb55602"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icon = WeatherIcon.PartlyCloudyDay.image
        let currentWeather = CurrentWeather(temperature: 56.0, humidity: 1.0, precipitationProbability: 1.0, summary: "Wet and Rainy!", icon: icon)
        display(currentWeather)
        
        let forecastURL = NSURL(string: "https://api.forecast.io/forecast/01ba71cbdee446dda597b43faeb55602/37.8267,-122.423")
        
        
    }

    func display(weather: CurrentWeather) {
        
        currentTemperatureLabel.text = weather.temperatureString
        currentPrecipitationLabel.text = weather.precipitationProbabilityString
        currentHumidityLabel.text = weather.humidityString
        currentSummaryLabel.text = weather.summary
        currentWeatherIcon.image = weather.icon
    }


}

