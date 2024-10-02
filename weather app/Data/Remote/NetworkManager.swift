//
//  NetworkManager.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//

import Foundation
import Moya

class NetworkManager {
    private let provider: MoyaProvider<WeatherAPI>
    
    // Dependency Injection via initializer
    init(provider: MoyaProvider<WeatherAPI> = MoyaProvider<WeatherAPI>()) {
        self.provider = provider
    }
    
    func getWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        provider.request(.getWeather(city: city)) { result in
            switch result {
            case .success(let response):
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: response.data)
                    completion(.success(weatherData))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
