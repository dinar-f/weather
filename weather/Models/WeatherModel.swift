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

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
}

struct WeatherCondition: Decodable {
    let main: String
}
