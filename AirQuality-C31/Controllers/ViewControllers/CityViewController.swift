//
//  CityViewController.swift
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    // MARK: - Properties
    var countryLanding: String?
    var stateLanding: String?
    var cityLanding: String?
    
    // MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var AQILabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let country = countryLanding, let state = stateLanding, let city = cityLanding else { return }
        JDCCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (airQuality) in
            self.updateViews(airQuality: airQuality)
        }
    }
    
    func updateViews(airQuality: JDCCityAirQuality) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = "City: \(airQuality.city)"
            self.AQILabel.text =
                "Air Quality Index: \(airQuality.pollution.airQualityIndex)"
            self.countryLabel.text = "Country: \(airQuality.country)"
            self.stateLabel.text = "State: \(airQuality.state)"
            self.temperatureLabel.text = "Temperature: \(airQuality.weather.temperature)"
            self.humidityLabel.text = "Humidity: \(airQuality.weather.humidity)"
            self.windSpeedLabel.text = "Windspeed: \(airQuality.weather.windSpeed)"
            self.title = self.cityLanding
        }
    }
}
