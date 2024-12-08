//
//  SearchViewModel.swift
//  weather
//
//  Created by Dinar on 07.12.2024.
//

class SearchViewModel {
    private let citiesService = CitiesService()
    private var citiesList: [CityInfo] = []
    
    func getCitiesList(cityName: String, completion: @escaping (Result<[CityInfo], Error>) -> Void) {
        citiesService.getCities(query: cityName){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.citiesList = response.suggestions.compactMap { suggestion in
                    guard let cityName = suggestion.data.city,
                          let region = suggestion.data.region_with_type,
                          let latitudeString = suggestion.data.geo_lat,
                          let longitudeString = suggestion.data.geo_lon else { return nil }
                    
                    guard let latitude = Double(latitudeString),
                          let longitude = Double(longitudeString) else { return nil }
                    
                    return CityInfo(cityName: cityName, latitude: latitude, longitude: longitude, region: region)
                }
                completion(.success(self.citiesList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

