//
//  ViewController.swift
//  Weather Clothing
//
//  Created by Cesare de Cal on 11/1/18.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTemperature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
    }
    
    func getWeatherData() {
        WeatherAPI.shared.getCurrentWeather(cityName: "Milan", countryCode: "IT", tempScale: .celsius) { (data) in
            print("got the data! here's dt:", data.dt)
            print("our maximimum for today is", data.main.temp_max)
            self.updateUI(weatherData: data)
        }
    }
    
    func updateUI(weatherData: WeatherData) {
        DispatchQueue.main.async {
            self.labelTemperature.text = String(weatherData.main.temp_max)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

