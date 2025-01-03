//
//  Constants.swift
//  weather
//
//  Created by Dinar on 04.12.2024.
//

enum Constants {
    enum WeatherApi {
        static let url: String = "https://api.openweathermap.org/data/2.5"
        static let apiKey = "07268a8cea9e8a3d097edd185c59bce0"
        static let weaterPath = "/weather"
        static let forecastPath = "/forecast"
    }
    enum CitiesApi {
        static let url: String = "https://suggestions.dadata.ru"
        static let apiKey = "ab5af727cc080cbdd45c8ac110433f30b42bd063"
        static let citiesPath = "/suggestions/api/4_1/rs/suggest/address"
    }
}

