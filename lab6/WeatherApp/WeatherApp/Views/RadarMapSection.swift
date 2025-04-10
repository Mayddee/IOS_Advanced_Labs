//
//  RadarMapSection.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import SwiftUI

struct RadarMapSection: View {
    var radarMap: RadarMapData?
    var isLoading: Bool
    var error: String?
    
    var body: some View {
        VStack {
            Text("Weather Radar")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if isLoading {
                LoadingErrorView(isLoading: true, error: nil, retryAction: {})
                    .frame(height: 200)
            } else if let errorMessage = error {
                LoadingErrorView(isLoading: false, error: errorMessage, retryAction: {})
                    .frame(height: 200)
            } else if let map = radarMap {
                VStack {
                    // В реальном приложении здесь был бы AsyncImage с картой
                    // Для демонстрации используем заглуш
                    // Для демонстрации используем заглушку с картой
                                        ZStack {
                                            Color.gray.opacity(0.2)
                                            
                                            // Симуляция радарной карты
                                            VStack {
                                                Image(systemName: "mappin.and.ellipse")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 40, height: 40)
                                                    .foregroundColor(.red)
                                                    .background(
                                                        Circle()
                                                            .fill(Color.red.opacity(0.2))
                                                            .frame(width: 100, height: 100)
                                                    )
                                                
                                                // Круги "радара"
                                                ForEach(1...3, id: \.self) { i in
                                                    Circle()
                                                        .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                                                        .frame(width: CGFloat(i) * 60, height: CGFloat(i) * 60)
                                                }
                                            }
                                            
                                            // Симуляция облаков
                                            Image(systemName: "cloud.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 60, height: 60)
                                                .foregroundColor(.blue.opacity(0.3))
                                                .offset(x: -60, y: -30)
                                            
                                            Image(systemName: "cloud.rain.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.blue.opacity(0.5))
                                                .offset(x: 70, y: 20)
                                        }
                                        .frame(height: 200)
                                        .cornerRadius(12)
                                        
                                        Text("Updated: \(formatDate(map.timestamp))")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                } else {
                                    Text("No radar data available")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding()
                                        .frame(height: 200)
                                        .background(Color.secondary.opacity(0.1))
                                        .cornerRadius(12)
                                }
                            }
                        }
                        
                        private func formatDate(_ date: Date) -> String {
                            let formatter = DateFormatter()
                            formatter.dateStyle = .none
                            formatter.timeStyle = .short
                            return formatter.string(from: date)
                        }
                    }

                    // Расширение для DateFormatter
                    extension DateFormatter {
                        static let forecastDateFormatter: DateFormatter = {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
                            return formatter
                        }()
                    }

//#Preview {
//    RadarMapSection()
//}
