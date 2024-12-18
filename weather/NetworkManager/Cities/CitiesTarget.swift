//
//  CitiesTarget.swift
//  weather
//
//  Created by Dinar on 07.12.2024.
//

import Moya

enum CitiesTarget {
    case fetchCities(query: String)
}

extension CitiesTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.CitiesApi.url)!
    }
    
    var path: String {
        switch self {
        case .fetchCities:
            return "/suggestions/api/4_1/rs/suggest/address"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCities:
            return .post
        }
    }
    
    var headers: [String: String]? {
        return ["Authorization": "Token \(Constants.CitiesApi.apiKey)",
                "Content-Type": "application/json"]
    }
    
    var task: Task {
        switch self {
        case let .fetchCities(query):
            let parameters: [String: Any] = [
                "query": query,
                "count": 1
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
