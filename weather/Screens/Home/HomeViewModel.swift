//
//  Home.swift
//  weather
//
//  Created by Dinar on 18.11.2024.
//

import CoreLocation

class HomeViewModel {
    private let locationService = LocationService()
    private let weatherService = WeatherService()
    var weatherInfo: WeatherInfo?
    
    func getMainWeather(completion: @escaping (Result<Void, Error>) -> Void) {
        locationService.requestLocation{ [weak self] coordinates in
            guard let self = self else { return }
            loadWeather(latitude: coordinates.latitude, longitude: coordinates.longitude) { result in
                completion(result)
            }
        }
    }
    
    func loadWeather(latitude:Double, longitude:Double, completion: @escaping (Result<Void, Error>) -> Void) {
        self.weatherService.getWeather(latitude: latitude, longitude: longitude ){ result in
            switch result {
            case .success(let weatherResponse):
                let roundedTemperature = String(Int(round(weatherResponse.main.temp)))
                let roundedFeelsLike = Int(round(weatherResponse.main.feelsLike))
                let cityName = weatherResponse.name
                let condition = weatherResponse.weather[0].main
                self.weatherInfo = WeatherInfo(cityName: cityName, temperature: roundedTemperature, feelsLike: roundedFeelsLike, condition: condition)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
