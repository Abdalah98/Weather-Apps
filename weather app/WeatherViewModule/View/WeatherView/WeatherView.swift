//
//  WeatherViewModel.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//

import SwiftUI

struct WeatherView: View {
    @State var city: String
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            TextField("Search for a city", text: $city, onCommit: {
                viewModel.fetchWeather(for: city)
            })
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)

            if let weatherData = viewModel.weatherData {
                WeatherDetailView(weatherData: weatherData)
            } else {
                Text("Fetching weather data...")
                    .onAppear {
                        viewModel.fetchWeather(for: city)
                    }
            }
        }
        .navigationTitle(city)
        .padding()
    }
}
