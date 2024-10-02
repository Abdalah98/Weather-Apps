//
//  CacheManager.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//

import Foundation


class CacheManager {
    static let weatherKey = "cachedWeatherData"
    
    static func saveWeatherData(_ data: WeatherData) {
        if let encodedData = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encodedData, forKey: weatherKey)
        }
    }

    static func loadCachedWeatherData() -> WeatherData? {
        if let savedData = UserDefaults.standard.data(forKey: weatherKey) {
            if let weatherData = try? JSONDecoder().decode(WeatherData.self, from: savedData) {
                return weatherData
            }
        }
        return nil
    }
}
