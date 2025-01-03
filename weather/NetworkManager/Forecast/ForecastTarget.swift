//
//  ForecastTarget.swift
//  weather
//
//  Created by Dinar on 12.12.2024.
//

import Moya

enum ForecastTarget {
    case fetchForecast(latitude: Double, longitude: Double)
}

extension ForecastTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.WeatherApi.url)!
    }
    
    var path: String {
        switch self {
        case .fetchForecast:
            return Constants.WeatherApi.forecastPath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchForecast:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var task: Task {
        switch self {
        case let .fetchForecast(latitude, longitude):
            return .requestParameters(parameters: [
                "lat": latitude,
                "lon": longitude,
                "units": "metric",
                "appid": Constants.WeatherApi.apiKey
            ], encoding: URLEncoding.default)
        }
    }
}
