import SwiftUI

struct WeatherDetailView: View {
    let weatherData: WeatherData
    
    @State private var selectedDay: String? = nil
    @State private var selectedTimePeriod: WeatherForecast? = nil
    @State private var isLoading = true
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            // Show loading or error state
            if isLoading {
                ProgressView("Loading weather data...")
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                // Top horizontal list of unique days
                DaySelectionView(uniqueDays: uniqueDays(),
                                 selectedDay: $selectedDay,
                                 selectedTimePeriod: $selectedTimePeriod,
                                 weatherData: weatherData)

                // Show the selected time period details
                if let selectedTimePeriod = selectedTimePeriod {
                    SelectedTimePeriodView(timePeriod: selectedTimePeriod)
                } else {
                    Text("Select a day and time period to view details")
                        .font(.headline)
                        .padding(.top, 20)
                }

                // Bottom horizontal list of time periods for the selected day
                if let selectedDay = selectedDay {
                    TimePeriodSelectionView(selectedDay: selectedDay,
                                            selectedTimePeriod: $selectedTimePeriod,
                                            weatherData: weatherData)
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            loadData()
        }
    }

    // MARK: - Helper Functions

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

    private func uniqueDays() -> [String] {
        var days = Set<String>()
        for forecast in weatherData.list ?? [] {
            let day = dayString(from: forecast.dt_txt)
            days.insert(day)
        }
        return Array(days).sorted()
    }

    private func weatherDataForDay(_ day: String) -> [WeatherForecast] {
        return (weatherData.list ?? []).filter { dayString(from: $0.dt_txt) == day }
    }

    private func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let firstDay = uniqueDays().first {
                selectedDay = firstDay
                selectedTimePeriod = weatherDataForDay(firstDay).first
                isLoading = false
            } else {
                errorMessage = "No weather data available"
                isLoading = false
            }
        }
    }
}
