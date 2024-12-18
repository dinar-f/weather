//
//  ForecastViewModel.swift
//  weather
//
//  Created by Dinar on 12.12.2024.
//
import UIKit

class ForecastViewModel {
    private let forecastService = ForecastService()
    var forecastsList: [ForecastInfo] = []
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()
    
    var weekdayFormatter: DateFormatter = {
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        weekdayFormatter.locale = Locale(identifier: "ru_RU")
        return weekdayFormatter
    }()
    
    
    func formatDate(dateString: String) -> String? {
        guard let date = dateFormatter.date(from: dateString) else {return nil}
        let dayOfWeek = weekdayFormatter.string(from: date)
        return dayOfWeek
    }
    
    func getforecast(latitude: Double, longitude: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        forecastService.getForecast(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let response):
                self.forecastsList = response.forecasts.compactMap { forecast in
                    let date = forecast.date
                    let minTemp = String(forecast.parts.day.tempMin)
                    let maxTemp = String(forecast.parts.day.tempMax)
                    let dayOfWeek = self.formatDate(dateString: date)
                    return ForecastInfo(
                        date: date,
                        minTemp: minTemp,
                        maxTemp: maxTemp,
                        weekDay:dayOfWeek)
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

