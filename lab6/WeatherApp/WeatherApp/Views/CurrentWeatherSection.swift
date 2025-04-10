//
//  CurrentWeatherSection.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import SwiftUI

struct CurrentWeatherSection: View {
    var isLoading: Bool
    var error: String?
    var currentConditions: (temp: Double, condition: String, humidity: Double, windSpeed: Double)
    
    var body: some View {
        VStack {
            Text("Current Conditions")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if isLoading {
                LoadingErrorView(isLoading: true, error: nil, retryAction: {})
                    .frame(height: 150)
            } else if let errorMessage = error {
                LoadingErrorView(isLoading: false, error: errorMessage, retryAction: {})
                    .frame(height: 150)
            } else {
                HStack(spacing: 20) {
                    VStack {
                        Image(systemName: getWeatherIcon(for: currentConditions.condition))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                        Text(currentConditions.condition)
                            .font(.headline)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: "thermometer")
                            Text(String(format: "%.1f°F", currentConditions.temp))
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        HStack {
                            Image(systemName: "humidity")
                            Text(String(format: "%.0f%%", currentConditions.humidity))
                        }
                        
                        HStack {
                            Image(systemName: "wind")
                            Text(String(format: "%.1f mph", currentConditions.windSpeed))
                        }
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            }
        }
    }
    
    func getWeatherIcon(for condition: String) -> String {
        let lowercased = condition.lowercased()
        
        if lowercased.contains("cloud") && lowercased.contains("sun") {
            return "cloud.sun.fill"
        } else if lowercased.contains("cloud") && lowercased.contains("rain") {
            return "cloud.rain.fill"
        } else if lowercased.contains("cloud") {
            return "cloud.fill"
        } else if lowercased.contains("rain") {
            return "cloud.rain.fill"
        } else if lowercased.contains("snow") {
            return "cloud.snow.fill"
        } else if lowercased.contains("thunder") {
            return "cloud.bolt.fill"
        } else if lowercased.contains("fog") || lowercased.contains("mist") {
            return "cloud.fog.fill"
        } else if lowercased.contains("wind") {
            return "wind"
        } else if lowercased.contains("sun") || lowercased.contains("clear") {
            return "sun.max.fill"
        }
        
        return "cloud.fill" // По умолчанию
    }
}


//#Preview {
//    CurrentWeatherSection()
//}
