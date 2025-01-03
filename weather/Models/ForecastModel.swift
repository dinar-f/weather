//
//  ForecastModel.swift
//  weather
//
//  Created by Dinar on 19.12.2024.
//

struct ForecastResponse: Codable {
    let list: [ForecastData]
}

struct ForecastData: Codable {
    let dateTimeStamp: Int
    let main: MainData
    let weather: [WeatherData]
    
    private enum CodingKeys: String, CodingKey {
        case dateTimeStamp = "dt"
        case main
        case weather
    }
}

struct WeatherData: Codable {
    let icon: String
}

struct MainData: Codable {
    let temp: Double
}

