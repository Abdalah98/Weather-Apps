//
//  weather_appApp.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//

import SwiftUI

@main
struct weather_appApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = WeatherViewModel()
            SearchView(
                viewModel: viewModel
            )
        }
    }
}
