//
//  locationService.swift
//  weather
//
//  Created by Dinar on 30.11.2024.
//


import UIKit
import Moya

struct WeatherResponse: Decodable {
    let main: Main
    let name: String
    let weather: [WeatherCondition]
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
}

struct WeatherCondition: Decodable {
    let main: String
}

class WeatherService {
    let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather";
    let weatherApiKey = "07268a8cea9e8a3d097edd185c59bce0";
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let weatherApiUrl: String = "\(weatherURL)?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(weatherApiKey)";
        guard let url = URL(string: weatherApiUrl) else { return }
        
        //        Просто хотел посмотреть как прописываются заголовки
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completion(.success(weatherResponse))
                } catch {
                    completion(.failure(NSError(domain: "", code: 3, userInfo: [NSLocalizedDescriptionKey: "Ошибка получения данных"])))}
            }
            
            if let error = error {
                completion(.failure(NSError(domain: "", code: 3, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])))
                return
            }
        }
        task.resume()
    }
}



//Moya

enum WeatherServiceAPI {
    case fetchWeather(latitude: Double, longitude: Double)
}

extension WeatherServiceAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5")!
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
                "appid": "07268a8cea9e8a3d097edd185c59bce0"
            ], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}


class AnotherWeatherService {
    private let provider = MoyaProvider<WeatherServiceAPI>()
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        provider.request(.fetchWeather(latitude: latitude, longitude: longitude)){ result in
            switch result {
            case .success(let response):
                do {
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: response.data)
                    completion(.success(weatherResponse))
                } catch {
                    completion(.failure(NSError(domain: "", code: 3, userInfo: [NSLocalizedDescriptionKey: "Ошибка получения данных"])))
                }
            case .failure(let error):
                completion(.failure(NSError(domain: "", code: 3, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])))
            }
        }
    }
}
