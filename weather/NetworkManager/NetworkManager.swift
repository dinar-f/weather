//
//  locationService.swift
//  weather
//
//  Created by Dinar on 30.11.2024.
//

import UIKit
import Moya


class NetworkManager {
    private let provider = MoyaProvider<MultiTarget>()
    
    func request<T:Decodable>(target: TargetType, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(MultiTarget(target)){ result in
            switch result{
            case .success(let response):
                do {
                    let result = try JSONDecoder.init().decode(T.self, from: response.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
    