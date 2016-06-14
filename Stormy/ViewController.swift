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
    
    
    lazy var forecastAPIClient = ForecastAPIClient(APIKey: "01ba71cbdee446dda597b43faeb55602")
    let coordinate = Coordinate(latitude: -40.04, longitude: 74.0)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastAPIClient.fetchCurrentWeather(coordinate) { result in
            switch result {
            case .Success(let currentWeather):
                self.display(currentWeather)
                
            case .Failure(let error as NSError):
                self.showAlert("Unable to retrieve forecast!", message: error.localizedDescription)
                
            default:
                break
            }
        }
        
    }

    func display(weather: CurrentWeather) {
        
        currentTemperatureLabel.text = weather.temperatureString
        currentPrecipitationLabel.text = weather.precipitationProbabilityString
        currentHumidityLabel.text = weather.humidityString
        currentSummaryLabel.text = weather.summary
        currentWeatherIcon.image = weather.icon
    }
    
    func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .Alert) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }


}

