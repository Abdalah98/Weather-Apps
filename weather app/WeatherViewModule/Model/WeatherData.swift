//
//  WeatherData.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//

import Foundation

struct WeatherData: Codable {
    let city: City?
    let list: [WeatherForecast]?
}

struct City: Codable {
    let name: String?
}

struct WeatherForecast: Codable {
    let dt_txt: String?
    let main: WeatherMain?
    let weather: [WeatherDescription]?
    let wind: Wind? // Add the wind property
}

struct WeatherMain: Codable {
    let temp: Double?
    let humidity: Int?
}

struct WeatherDescription: Codable {
    let description: String?
}

struct Wind: Codable {
    let speed: Double?
}
