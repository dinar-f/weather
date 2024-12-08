//
//  CitiesService.swift
//  weather
//
//  Created by Dinar on 07.12.2024.
//

class CitiesService {
    let networkManager = NetworkManager()
    
    func getCities(query: String, completion: @escaping ((Result<DadataResponse, Error>) -> Void)){
        networkManager.request(target: CitiesTarget.fetchCities(query: query), completion: { result in
            completion(result)
        })
    }
}
