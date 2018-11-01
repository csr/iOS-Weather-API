//
//  WeatherAPI.swift
//  Weather Clothing
//
//  Created by Cesare de Cal on 11/1/18.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import Foundation

class WeatherAPI: NSObject {
    
    static let shared = WeatherAPI()
    
    func getCurrentWeather(cityName: String, countryCode: String, tempScale: TemperatureScale, completionHandler: @escaping ((WeatherData) -> ())) {
        
        guard let sanitizedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            print("Error: while sanitizing city name")
            return
        }
        
        guard let key = getAPIKey() else {
            print("Error: could not extract API key")
            return
        }
        
        // Set up the URL request
        let endpointString = "https://api.openweathermap.org/data/2.5/weather?q=\(sanitizedCityName),\(countryCode)&units=\(tempScale.rawValue)&APPID=\(key)"
        
        print("final request string:", endpointString)
        
        guard let url = URL(string: endpointString) else {
            print("error: URL NOT valid")
            return
        }
        
        print("final request string:", endpointString)
        let urlRequest = URLRequest(url: url)
        
        // Set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // Make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // Check for any errors
            if let error = error {
                print("error calling GET on current weather:", error.localizedDescription)
                return
            }
            
            // Make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("Error trying to convert data to JSON")
                    return
                }
                print(jsonData)
                
                // Parse the result as JSON, since that's what the API provides
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: responseData)
                completionHandler(weatherData)
            } catch {
                print("Error: conversion to JSON")
            }
        }
        
        task.resume()
    }
    
    func getAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
        let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any], let key = dictionary["weatherAPIKey"] as? String {
            return key
        }
        return nil
    }
}
