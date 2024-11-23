//
//  Home.swift
//  weather
//
//  Created by Dinar on 18.11.2024.
//

import CoreLocation

class HomeViewModel {
    var locationUpdate: ((Result<(Double, Double), Error>) -> Void)?
    
    func requestLocation() {
        LocationManager.shared.getUserLocation { [weak self] location in
            self?.locationUpdate?(location)
        }
    }
}
