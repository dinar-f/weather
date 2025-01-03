//
//  ForecastViewModel.swift
//  weather
//
//  Created by Dinar on 12.12.2024.
//

import Foundation

class ForecastViewModel {
    private let forecastService = ForecastService()
    let dateFormatterService = DateFormatterService.shared
    var forecastsList: [ForecastInfo] = []
    
    func getforecast(latitude: Double, longitude: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        forecastService.getForecast(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let response):
                self.forecastsList = response.list.prefix(7).compactMap { forecast in
                    let temp = Int(round(forecast.main.temp))
                    let time = self.dateFormatterService.timeStringFromTimeStamp(timeStamp: forecast.dateTimeStamp)
                    let weekDay = self.dateFormatterService.weekStringFromimeStamp(timeStamp: forecast.dateTimeStamp)
                    let icon = forecast.weather[0].icon
                    return ForecastInfo(
                        temp: temp,
                        time: time,
                        weekDay: weekDay,
                        icon: icon
                    )
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

