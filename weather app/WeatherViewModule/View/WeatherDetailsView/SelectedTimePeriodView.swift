//
//  SelectedTimePeriodView.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//


import SwiftUI

struct SelectedTimePeriodView: View {
    let timePeriod: WeatherForecast

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: getWeatherIcon(for: timePeriod.weather?.first?.description ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(getIconColor(for: timePeriod.weather?.first?.description ?? ""))

            Text("\(Int(timePeriod.main?.temp ?? 0))°")
                .font(.system(size: 50))
                .bold()

            Text(timePeriod.weather?.first?.description?.capitalized ?? "No description available")
                .font(.title3)
                .padding(.top, 5)

            Text("Wind Speed: \(timePeriod.wind?.speed ?? 0, specifier: "%.1f") m/s")
                .font(.subheadline)
                .padding(.bottom, 20)
        }
    }

    private func getWeatherIcon(for description: String) -> String {
        switch description.lowercased() {
        case "clear sky":
            return "sun.max.fill"
        case "few clouds":
            return "cloud.sun.fill"
        case "rain":
            return "cloud.rain.fill"
        case "snow":
            return "cloud.snow.fill"
        default:
            return "cloud.fill"
        }
    }

    private func getIconColor(for description: String) -> Color {
        switch description.lowercased() {
        case "clear sky":
            return Color.yellow
        case "few clouds", "scattered clouds", "broken clouds", "overcast clouds":
            return Color.gray
        case "rain", "light rain", "moderate rain", "heavy rain":
            return Color.blue
        case "snow":
            return Color.white
        default:
            return Color.gray
        }
    }
}
