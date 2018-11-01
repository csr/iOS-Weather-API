//
//  WelcomeController.swift
//  Weather Clothing
//
//  Created by Cesare de Cal on 11/1/18.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import MapKit

class WelcomeController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    func presentNextController() {
        performSegue(withIdentifier: "weatherControllerSegue", sender: self)
    }
    
    func requestLocationPermissions() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func didTapAcceptButton(_ sender: UIButton) {
        requestLocationPermissions()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
