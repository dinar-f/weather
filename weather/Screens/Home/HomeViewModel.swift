//
//  Home.swift
//  weather
//
//  Created by Dinar on 18.11.2024.
//

import CoreLocation

struct WeatherInfo {
    let cityName: String
    let temperature: String
    let feelsLike: Int
    let condition : String
}

class HomeViewModel {
    private let locationService = LocationService()
    private let weatherService = WeatherService()
    var weatherInfo: WeatherInfo?
    
    func loadWeather(completion: @escaping (Result<Void, Error>) -> Void) {
        locationService.requestLocation{ [weak self] coordinates in
            guard let self = self else { return }
            self.weatherService.fetchWeather(latitude: coordinates.latitude, longitude: coordinates.longitude ){ result in
                switch result {
                case .success(let weatherResponse):
                    let roundedTemperature = String(Int(round(weatherResponse.main.temp)))
                    let roundedFeelsLike = Int(round(weatherResponse.main.feels_like))
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
}
