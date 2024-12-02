//
//  locationService.swift
//  weather
//
//  Created by Dinar on 30.11.2024.
//


import UIKit

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


