//
//  WeatherService.swift
//  weather
//
//  Created by Dinar on 04.12.2024.
//

class WeatherService {
    let networkManager = NetworkManager()
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping ((Result<WeatherResponse, Error>) -> Void)){
        networkManager.request(target: WeatherTarget.fetchWeather(latitude: latitude, longitude: longitude), completion: { result in
            completion(result)
        })
    }
}
