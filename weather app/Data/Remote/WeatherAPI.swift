//
//  WeatherAPI.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//


import Foundation
import Moya

enum WeatherAPI {
    case getWeather(city: String)
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5")!
    }

    var path: String {
        switch self {
        case .getWeather:
            return "/forecast"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getWeather(let city):
            return .requestParameters(parameters: ["q": city, "appid": "b5ff0338cc0b5aff7e088673ae38811a", "units": "metric"], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data() // We can add mock data here for testing
    }
}
