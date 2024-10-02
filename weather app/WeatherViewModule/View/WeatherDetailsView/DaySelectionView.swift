//
//  DaySelectionView.swift
//  weather app
//
//  Created by Abdalah on 02/10/2024.
//


import SwiftUI

struct DaySelectionView: View {
    let uniqueDays: [String]
    @Binding var selectedDay: String?
    @Binding var selectedTimePeriod: WeatherForecast?
    let weatherData: WeatherData

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(uniqueDays, id: \.self) { day in
                    VStack {
                        Text(day)
                            .bold()
                            .padding()
                            .background(selectedDay == day ? Color.blue.opacity(0.2) : Color.clear)
                            .cornerRadius(10)
                    }
                    .onTapGesture {
                        selectedDay = day
                        selectedTimePeriod = weatherDataForDay(day).first
                    }
                }
            }
        }
        .padding(.top)
    }

    private func weatherDataForDay(_ day: String) -> [WeatherForecast] {
        return (weatherData.list ?? []).filter { dayString(from: $0.dt_txt) == day }
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
