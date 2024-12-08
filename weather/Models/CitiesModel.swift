//
//  CitiesModel.swift
//  weather
//
//  Created by Dinar on 07.12.2024.
//

import Foundation

struct DadataResponse: Codable {
    let suggestions: [CitySuggestion]
}

struct CitySuggestion: Codable {
    let data: CityData
}

struct CityData: Codable {
    let city: String?
    let geo_lat: String?
    let geo_lon: String?
    let region_with_type: String?
}

