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
        return URL(string: Constants.ForecastApi.url)!
    }
    
    var path: String {
        switch self {
        case .fetchForecast:
            return "/forecast"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchForecast:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "X-Yandex-Weather-Key": Constants.ForecastApi.apiKey]
    }
    
    var task: Task {
        switch self {
        case let .fetchForecast(latitude, longitude):
            return .requestParameters(parameters: [
                "lat": latitude,
                "lon": longitude,
                "limit": 7,
            ], encoding: URLEncoding.default)
        }
    }
}

