//
//  NetworkManagerTests.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//

import XCTest
import Moya
import Combine
@testable import weather_app



class MockNetworkManager: NetworkManager {
    var result: Result<WeatherData, Error>?

    override func getWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}

class WeatherViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    
    func testFetchWeatherSuccess() {
        let mockWeatherData = WeatherData(city: City(name: "Test City"), list: [])
        
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .success(mockWeatherData)
        
        let viewModel = WeatherViewModel(networkManager: mockNetworkManager)
        
        let expectation = self.expectation(description: "Weather data should be fetched successfully")

        viewModel.$weatherData
            .sink { weatherData in
                if let weatherData = weatherData {
                    XCTAssertEqual(weatherData.city?.name, "Test City")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Call fetchWeather
        viewModel.fetchWeather(for: "Test City")
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchWeatherFailure() {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.result = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
        
        let viewModel = WeatherViewModel(networkManager: mockNetworkManager)
        
        let expectation = self.expectation(description: "Weather data should fail to fetch")

        viewModel.$errorMessage
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    XCTAssertEqual(errorMessage, "Failed to fetch weather: The operation couldn’t be completed. (TestError error -1.)")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchWeather(for: "Test City")
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
