//
//  WeatherController.swift
//  Weather Clothing
//
//  Created by Cesare de Cal on 11/1/18.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import MapKit

class WeatherController: UIViewController {

    let locationManager = CLLocationManager()
        
    @IBOutlet weak var segmentedControlScale: UISegmentedControl!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUserLocation()
    }
    
    func getWeatherData(cityName: String, countryCode: String, scale: TemperatureScale) {
        WeatherAPI.shared.getCurrentWeather(cityName: cityName, countryCode: countryCode, tempScale: scale) { (data) in
            self.updateUI(weatherData: data, scale: scale)
        }
    }
    
    func updateUI(weatherData: WeatherData, scale: TemperatureScale) {
        DispatchQueue.main.async {
            self.labelTemperature.text = String(weatherData.main.temp) + " \(scale.symbolForScale())"
        }
    }
    
    @IBAction func didTapRefreshButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func didChangeSegmentedControlValue(_ sender: UISegmentedControl) {
        locationManager.requestLocation()
    }
    
    func getCurrentTemperatureScaleSelection() -> TemperatureScale {
        switch segmentedControlScale.selectedSegmentIndex {
        case 0:
            return .celsius
        case 1:
            return .fahrenheit
        default:
            fatalError()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

