//
//  LocationManager.swift
//  weather
//
//  Created by Dinar on 21.11.2024.
//

import UIKit
import SnapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    var locationCompletion: ((Result<(Double, Double), Error>) -> Void)?
    
    public func getUserLocation(completion: ((Result<(Double, Double), Error>) -> Void)?) {
        self.locationCompletion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let coordinates = (location.coordinate.latitude, location.coordinate.longitude)
        locationCompletion?(.success(coordinates))
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationCompletion?(.failure(NSError(domain: "LocationError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Ошибка получения геолокации"])))
    }
}

