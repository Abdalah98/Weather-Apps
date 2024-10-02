
# Weather Apps

A simple iOS Weather App built using Swift, SwiftUI, and Moya. The app fetches weather data for a given city and displays the current weather and a 5-day forecast.

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Running the App](#running-the-app)
- [Testing](#testing)
- [Project Structure](#project-structure)
- [License](#license)

## Requirements

- Xcode 13 or later (Xcode 16 recommended)
- iOS 14.0 or later
 
## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/Abdalah98/Weather-Apps.git
   ```


## Running the App

1. Open **Xcode** and select your target device or simulator.
2. Click the **Run** button (or use the shortcut `Cmd + R`) to build and run the app.

The app will fetch weather data using the OpenWeather API and display it on the UI.

## Testing

Unit tests are written using Xcode's testing framework. To run the tests:

1. Open **Xcode** and select the `weather app.xcodeproj` file.
2. In the menu, go to **Product > Test** or use the shortcut `Cmd + U`.

Alternatively, you can run tests from the terminal with the following command:

```bash
xcodebuild test -scheme "Weather App" -enableCodeCoverage YES
```

This will run the unit tests and provide code coverage data.

## Project Structure

- `WeatherApp/`: Contains the main application code.
  - `Models/`: Contains the data models used by the app.
  - `ViewModels/`: Contains the business logic and state management.
  - `Views/`: Contains the UI components built using SwiftUI.
  - `Network/`: Contains the networking code, including the API client powered by Moya.
  
- `Tests/`: Contains unit tests for the app.

## Dependencies

- [Moya](https://github.com/Moya/Moya) – A network abstraction layer.
- [Combine](https://developer.apple.com/documentation/combine) – Apple’s framework for handling asynchronous events by combining event-processing operators.

![WhatsApp Image 2024-10-02 at 11 08 20 PM](https://github.com/user-attachments/assets/5644858e-4de8-4212-bb86-d2fd10e75276)

![WhatsApp Image 2024-10-02 at 11 08 13 PM](https://github.com/user-attachments/assets/6ae58f3b-18c1-4522-a578-bf1d81f85983)




