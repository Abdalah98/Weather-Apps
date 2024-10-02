//
//  WeatherViewModel.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var errorMessage: String?
    
    private let networkManager: NetworkManager
    
    // Dependency Injection via initializer
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchWeather(for city: String) {
        networkManager.getWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.weatherData = data
                    CacheManager.saveWeatherData(data)
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func loadCachedWeather() {
        if let cachedData = CacheManager.loadCachedWeatherData() {
            self.weatherData = cachedData
        }
    }
}

