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

struct CityData : Codable {
    let city: String?
    let latitude: String?
    let longitude: String?
    let region: String?
    
    private enum CodingKeys : String, CodingKey {
        case city
        case latitude = "geo_lat"
        case longitude = "geo_lon"
        case region = "region_with_type"
    }
}
