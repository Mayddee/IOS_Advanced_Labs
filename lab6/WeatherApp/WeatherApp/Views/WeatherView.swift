//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var citySearch: String = ""
    @State private var coordinates = (lat: 44.9778, lon: -93.2650)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    SearchBarView(citySearch: $citySearch) {
                        viewModel.searchCity(citySearch)
                    }
                    
                    // Заголовок с местоположением
                    LocationHeaderView(
                        locationName: viewModel.locationName,
                        isLoading: viewModel.locationIsLoading
                    )
                    
                    // Текущие условия (всегда показываем, с индикатором загрузки)
                    CurrentWeatherSection(
                        isLoading: viewModel.currentConditionsIsLoading,
                        error: viewModel.currentConditionsError,
                        currentConditions: viewModel.currentConditions
                    )
                    
                    // Предупреждения (показываем только если есть)
                    AlertsSection(
                        alerts: viewModel.alerts,
                        isLoading: viewModel.alertsIsLoading,
                        error: viewModel.alertsError
                    )
                    
                    // Качество воздуха
                    AirQualitySection(
                        airQuality: viewModel.airQuality,
                        isLoading: viewModel.airQualityIsLoading,
                        error: viewModel.airQualityError
                    )
                    
                    // Прогноз на 5 дней
                    ForecastSection(
                        forecast: viewModel.forecast,
                        isLoading: viewModel.forecastIsLoading,
                        error: viewModel.forecastError
                    )
                    
                    // Радарная карта
                    RadarMapSection(
                        radarMap: viewModel.radarMap,
                        isLoading: viewModel.radarMapIsLoading,
                        error: viewModel.radarMapError
                    )
                }
                .padding()
                .animation(.easeInOut, value: viewModel.isLoading)
            }
            .navigationTitle("Weather")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.fetchAllWeather(lat: coordinates.lat, lon: coordinates.lon)
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Refresh")
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchAllWeather(lat: coordinates.lat, lon: coordinates.lon)
            }
        }
        .preferredColorScheme(.light)
    }
}


#Preview {
    WeatherView()
}
