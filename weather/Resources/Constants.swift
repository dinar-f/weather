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
    }
    enum ForecastApi {
        static let url: String = "https://api.weather.yandex.ru/v2"
        static let apiKey = "3dcc4ebf-09a9-4ad9-833b-f039229b5d80"
    }
    enum CitiesApi {
        static let url: String = "https://suggestions.dadata.ru"
        static let apiKey = "ab5af727cc080cbdd45c8ac110433f30b42bd063"
    }
}

