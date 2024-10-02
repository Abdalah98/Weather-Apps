//
//  SearchView.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//
import SwiftUI

struct SearchView: View {
    @State private var city: String = ""
    @State private var navigateToWeather: Bool = false
    @ObservedObject var viewModel: WeatherViewModel
    @State private var previousSearches: [String] = []
    @State private var errorMessage: String? = nil
    
    let userDefaultsKey = "cachedSearches"
    let maxSearches = 5
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Search bar
                TextField("Enter City Name", text: $city)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .disableAutocorrection(true)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                Button("Get Weather") {
                    // Validate input before proceeding
                    if validateInput() {
                        saveSearch(city: city)
                        viewModel.fetchWeather(for: city)
                        navigateToWeather = true
                    }
                }
                .padding()
                .buttonStyle(PrimaryButtonStyle())

                // Navigation to WeatherView
                NavigationLink(destination: WeatherView(city: city, viewModel: viewModel), isActive: $navigateToWeather) {
                    EmptyView()
                }

                // Display cached previous searches
                if !previousSearches.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Previous Searches:")
                            .font(.headline)
                            .padding(.leading)
                        
                        ScrollView {
                            ForEach(previousSearches, id: \.self) { search in
                                Button(action: {
                                    city = search
                                    viewModel.fetchWeather(for: search)
                                    navigateToWeather = true
                                }) {
                                    Text(search)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search Weather")
            .onAppear {
                loadPreviousSearches()
            }
        }
    }

    // Validate input for empty city field
    private func validateInput() -> Bool {
        if city.isEmpty {
            errorMessage = "Please enter a city name"
            return false
        }
        errorMessage = nil
        return true
    }

    private func saveSearch(city: String) {
        var searches = UserDefaults.standard.stringArray(forKey: userDefaultsKey) ?? []
        
        if !searches.contains(city) {
            if searches.count >= maxSearches {
                searches.removeFirst()
            }
            searches.append(city)
            UserDefaults.standard.setValue(searches, forKey: userDefaultsKey)
        }
    }

    private func loadPreviousSearches() {
        previousSearches = UserDefaults.standard.stringArray(forKey: userDefaultsKey) ?? []
    }
}


