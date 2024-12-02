//
//  LocationManager.swift
//  weather
//
//  Created by Dinar on 21.11.2024.
//

import UIKit
import SnapKit
import CoreLocation


class LocationService: NSObject{
    private var locationManager = CLLocationManager()
    private var locationCompletion: ((CLLocationCoordinate2D) -> Void)?
    
    
    func requestLocation(completion: @escaping ((CLLocationCoordinate2D) -> Void)) {
        self.locationCompletion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        locationCompletion?(location.coordinate)
        locationCompletion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationCompletion = nil
    }
}
