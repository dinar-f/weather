//
//  ForecastService.swift
//  weather
//
//  Created by Dinar on 12.12.2024.
//

class ForecastService {
    let networkManager = NetworkManager.shared
    
    func getForecast(latitude: Double, longitude: Double, completion: @escaping ((Result<ForecastResponse, Error>) -> Void)){
        networkManager.request(target: ForecastTarget.fetchForecast(latitude: latitude, longitude: longitude), completion: { result in
            completion(result)
        })
    }
}
