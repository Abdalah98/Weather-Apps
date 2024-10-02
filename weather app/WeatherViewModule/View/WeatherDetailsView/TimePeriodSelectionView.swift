//
//  TimePeriodSelectionView.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//


import SwiftUI

struct TimePeriodSelectionView: View {
    let selectedDay: String
    @Binding var selectedTimePeriod: WeatherForecast?
    let weatherData: WeatherData

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(weatherDataForDay(selectedDay), id: \.dt_txt) { forecast in
                    VStack {
                        Text(timeString(from: forecast.dt_txt))
                            .bold()
                            .padding()
                            .background(selectedTimePeriod?.dt_txt == forecast.dt_txt ? Color.blue.opacity(0.2) : Color.clear)
                            .cornerRadius(10)
                    }
                    .onTapGesture {
                        selectedTimePeriod = forecast
                    }
                }
            }
        }
        .padding(.top)
    }

    private func weatherDataForDay(_ day: String) -> [WeatherForecast] {
        return (weatherData.list ?? []).filter { dayString(from: $0.dt_txt) == day }
    }

    private func timeString(from dateString: String?) -> String {
        guard let dateString = dateString else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
        return ""
    }

    private func dayString(from dateString: String?) -> String {
        guard let dateString = dateString else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "E"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
