//
//  W.swift
//  weather
//
//  Created by Dinar on 04.12.2024.
//

import Moya

enum WeatherTarget {
    case fetchWeather(latitude: Double, longitude: Double)
}

extension WeatherTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.WeatherApi.url)!
    }
    
    var path: String {
        switch self {
        case .fetchWeather:
            return "/weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWeather:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var task: Task {
        switch self {
        case let .fetchWeather(latitude, longitude):
            return .requestParameters(parameters: [
                "lat": latitude,
                "lon": longitude,
                "units": "metric",
                "appid": Constants.WeatherApi.apiKey
            ], encoding: URLEncoding.default)
        }
    }
}
