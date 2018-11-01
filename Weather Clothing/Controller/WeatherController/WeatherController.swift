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

    @IBOutlet weak var segmentedControlScale: UISegmentedControl!
    @IBOutlet weak var labelTemperature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData(scale: .celsius)
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    func getWeatherData(scale: TemperatureScale) {
        WeatherAPI.shared.getCurrentWeather(cityName: "Milan", countryCode: "IT", tempScale: scale) { (data) in
            self.updateUI(weatherData: data, scale: scale)
        }
    }
    
    func updateUI(weatherData: WeatherData, scale: TemperatureScale) {
        DispatchQueue.main.async {
            self.labelTemperature.text = String(weatherData.main.temp_max) + " \(scale.symbolForScale())"
        }
    }
    
    @IBAction func didTapRefreshButton(_ sender: UIButton) {
        let currentScaleTemp = getCurrentTemperatureScaleSelection()
        getWeatherData(scale: currentScaleTemp)
    }
    
    @IBAction func didChangeSegmentedControlValue(_ sender: UISegmentedControl) {
        let scaleTemp = getCurrentTemperatureScaleSelection()
        getWeatherData(scale: scaleTemp)
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

