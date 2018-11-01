//
//  WeatherController-Location.swift
//  Weather Clothing
//
//  Created by Cesare de Cal on 11/1/18.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import MapKit

extension WeatherController: CLLocationManagerDelegate {
    
    func getCurrentUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.requestLocation()
        }
    }
    
    func getLocationName(location: CLLocation) {
        fetchCityAndCountry(from: location) { city, countryCode, error in
            guard let city = city, let countryCode = countryCode, error == nil else {
                print("Error occurred while fetching city and country")
                return
            }
            print("here is your location name")
            self.labelLocation.text = city + ", " + countryCode
            
            
            print(city + ", " + countryCode) // Rio de Janeiro, Brazil
            self.getWeatherData(cityName: city, countryCode: countryCode, scale: self.getCurrentTemperatureScaleSelection())
        }
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.isoCountryCode,
                       error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {        
        guard let location = manager.location else {
            print("Warning: location is nil")
            return
        }
        print("locations count:", locations.count)
        getLocationName(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
