//
//  ForecastModel.swift
//  weather
//
//  Created by Dinar on 19.12.2024.
//

struct ForecastResponse: Codable {
    let forecasts: [ForecastData]
}

struct ForecastData: Codable {
    let date: String
    let parts: Parts
}

struct Parts: Codable {
    let day: Day
    
    struct Day: Codable {
        let daytime: String
        let condition: String
        let tempMin: Int
        let tempMax: Int
        
        private enum CodingKeys: String, CodingKey {
            case daytime, condition, tempMin = "temp_min", tempMax = "temp_max"
        }
    }
}
