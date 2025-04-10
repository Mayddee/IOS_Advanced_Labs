//
//  ForecastSection.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import SwiftUI

struct ForecastSection: View {
    var forecast: [ForecastPeriod]
    var isLoading: Bool
    var error: String?
    
    var body: some View {
        VStack {
            Text("5-Day Forecast")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if isLoading {
                LoadingErrorView(isLoading: true, error: nil, retryAction: {})
                    .frame(height: 150)
            } else if let errorMessage = error {
                LoadingErrorView(isLoading: false, error: errorMessage, retryAction: {})
                    .frame(height: 150)
            } else if forecast.isEmpty {
                Text("No forecast data available")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                VStack(spacing: 12) {
                    ForEach(Array(forecast.prefix(5))) { day in
                        HStack {
                            Text(day.name)
                                .frame(width: 100, alignment: .leading)
                            
                            if let icon = day.icon {
                                AsyncImage(url: URL(string: icon)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Image(systemName: "cloud")
                                }
                                .frame(width: 30, height: 30)
                            } else {
                                Image(systemName: "cloud")
                                    .frame(width: 30, height: 30)
                            }
                            
                            Text(day.shortForecast)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                            
                            Text("\(day.temperature)°\(day.temperatureUnit)")
                                .fontWeight(.bold)
                        }
                        
                        if day.id != forecast.prefix(5).last?.id {
                            Divider()
                        }
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            }
        }
    }
}

//#Preview {
//    ForecastSection()
//}
