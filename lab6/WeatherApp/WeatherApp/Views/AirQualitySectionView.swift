//
//  AirQualitySectionView.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import SwiftUI

struct AirQualitySection: View {
    var airQuality: (aqi: Int, category: String)
    var isLoading: Bool
    var error: String?
    
    var body: some View {
        VStack {
            Text("Air Quality")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if isLoading {
                LoadingErrorView(isLoading: true, error: nil, retryAction: {})
                    .frame(height: 100)
            } else if let errorMessage = error {
                LoadingErrorView(isLoading: false, error: errorMessage, retryAction: {})
                    .frame(height: 100)
            } else {
                HStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 8.0)
                            .opacity(0.3)
                            .foregroundColor(aqiColor(airQuality.aqi))
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(Double(airQuality.aqi) / 300.0, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(aqiColor(airQuality.aqi))
                            .rotationEffect(Angle(degrees: 270.0))
                        
                        VStack {
                            Text("\(airQuality.aqi)")
                                .font(.title)
                                .bold()
                            Text("AQI")
                                .font(.caption)
                        }
                    }
                    .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading) {
                        Text(airQuality.category)
                            .font(.headline)
                            .foregroundColor(aqiColor(airQuality.aqi))
                        
                        Text(aqiDescription(airQuality.aqi))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(12)
            }
        }
    }
    
    func aqiColor(_ aqi: Int) -> Color {
        switch aqi {
        case 0...50: return .green
        case 51...100: return .yellow
        case 101...150: return .orange
        case 151...200: return .red
        case 201...300: return .purple
        default: return .brown
        }
    }
    
    func aqiDescription(_ aqi: Int) -> String {
        switch aqi {
        case 0...50: return "Good - Air quality is considered satisfactory"
        case 51...100: return "Moderate - Air quality is acceptable"
        case 101...150: return "Unhealthy for sensitive groups"
        case 151...200: return "Unhealthy - Everyone may experience effects"
        case 201...300: return "Very Unhealthy - Health warnings of emergency conditions"
        default: return "Hazardous - Health alert: everyone may experience serious effects"
        }
    }
}


//#Preview {
//    AirQualitySectionView()
//}
