//
//  WeatherModel.swift
//  weather
//
//  Created by Dinar on 04.12.2024.
//

struct WeatherResponse: Decodable {
    let main: Main
    let name: String
    let weather: [WeatherCondition]
}

struct Main : Codable {
    let temp: Double
    let feelsLike: Double
    
    private enum CodingKeys : String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct WeatherCondition: Decodable {
    let main: String
}
