//
//  WetherViewModel.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    // Опубликованные свойства для каждого компонента
    @Published var forecast: [ForecastPeriod] = []
    @Published var alerts: [WeatherAlert] = []
    @Published var airQuality: (aqi: Int, category: String) = (0, "Unknown")
    @Published var currentConditions: (temp: Double, condition: String, humidity: Double, windSpeed: Double) = (0, "Unknown", 0, 0)
    @Published var radarMap: RadarMapData?
    @Published var locationName: String = "Unknown"
    
    // Статусы загрузки для каждого компонента
    @Published var forecastIsLoading = false
    @Published var alertsIsLoading = false
    @Published var airQualityIsLoading = false
    @Published var currentConditionsIsLoading = false
    @Published var radarMapIsLoading = false
    @Published var locationIsLoading = false
    
    // Ошибки для каждого компонента
    @Published var forecastError: String?
    @Published var alertsError: String?
    @Published var airQualityError: String?
    @Published var currentConditionsError: String?
    @Published var radarMapError: String?
    @Published var locationError: String?
    
    // Объединенное свойство для общего контроля загрузки
    var isLoading: Bool {
        return forecastIsLoading || alertsIsLoading || airQualityIsLoading ||
               currentConditionsIsLoading || radarMapIsLoading || locationIsLoading
    }
    
    var errorMessage: String? {
        if let error = forecastError { return "Forecast: \(error)" }
        if let error = alertsError { return "Alerts: \(error)" }
        if let error = airQualityError { return "Air Quality: \(error)" }
        if let error = currentConditionsError { return "Current Conditions: \(error)" }
        if let error = radarMapError { return "Radar Map: \(error)" }
        if let error = locationError { return "Location: \(error)" }
        return nil
    }
    
    private var tasks: [Task<Void, Never>] = []
    private let cache = NetworkCache.shared
    
    func fetchAllWeather(lat: Double, lon: Double) {
        // Отменяем все предыдущие задачи
        cancelAllTasks()
        
        // Сбрасываем ошибки
        resetAllErrors()
        
        // Запускаем параллельные задачи для каждого компонента
        tasks.append(Task { await fetchForecast(lat: lat, lon: lon) })
        tasks.append(Task { await fetchAlerts(lat: lat, lon: lon) })
        tasks.append(Task { await fetchAirQuality(lat: lat, lon: lon) })
        tasks.append(Task { await fetchCurrentConditions(lat: lat, lon: lon) })
        tasks.append(Task { await fetchRadarMap(lat: lat, lon: lon) })
        tasks.append(Task { await fetchLocationName(lat: lat, lon: lon) })
    }
    
    private func resetAllErrors() {
        forecastError = nil
        alertsError = nil
        airQualityError = nil
        currentConditionsError = nil
        radarMapError = nil
        locationError = nil
    }
    
    private func cancelAllTasks() {
        for task in tasks {
            task.cancel()
        }
        tasks.removeAll()
    }
    
    func cancel() {
        cancelAllTasks()
    }
    
    // Методы загрузки данных
    
    @MainActor
    func fetchForecast(lat: Double, lon: Double) async {
        let key = "forecast-\(lat),\(lon)"
        
        forecastIsLoading = true
        forecastError = nil
        
        do {
            // Проверяем кэш
            if let cached = NetworkCache.shared.loadData(forKey: key),
               let decoded = try? JSONDecoder().decode(ForecastResponse.self, from: cached) {
                self.forecast = decoded.properties.periods
                forecastIsLoading = false
                return
            }
            
            // Получаем данные с API
            let pointsURL = URL(string: "https://api.weather.gov/points/\(lat),\(lon)")!
            var pointsReq = URLRequest(url: pointsURL)
            pointsReq.setValue("WeatherApp (you@yourapp.com)", forHTTPHeaderField: "User-Agent")
            
            let (pointsData, _) = try await URLSession.shared.data(for: pointsReq)
            let pointsJSON = try JSONSerialization.jsonObject(with: pointsData) as? [String: Any]
            
            guard let properties = pointsJSON?["properties"] as? [String: Any],
                  let forecastURLStr = properties["forecast"] as? String,
                  let forecastURL = URL(string: forecastURLStr) else {
                throw URLError(.badURL)
            }
            
            var forecastReq = URLRequest(url: forecastURL)
            forecastReq.setValue("WeatherApp (you@yourapp.com)", forHTTPHeaderField: "User-Agent")
            
            let (data, _) = try await URLSession.shared.data(for: forecastReq)
            let decoded = try JSONDecoder().decode(ForecastResponse.self, from: data)
            
            self.forecast = decoded.properties.periods
            NetworkCache.shared.saveData(data, forKey: key)
        } catch {
            forecastError = error.localizedDescription
        }
        
        forecastIsLoading = false
    }
    
    @MainActor
    func fetchAlerts(lat: Double, lon: Double) async {
        alertsIsLoading = true
        alertsError = nil
        
        do {
            guard let url = URL(string: "https://api.weather.gov/alerts/active?point=\(lat),\(lon)") else {
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            request.setValue("WeatherApp (you@yourapp.com)", forHTTPHeaderField: "User-Agent")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(AlertResponse.self, from: data)
            
            let mappedAlerts = response.features.map { feature in
                WeatherAlert(
                    id: feature.id,
                    title: feature.properties.headline,
                    description: feature.properties.description
                )
            }
            
            self.alerts = mappedAlerts
        } catch {
            alertsError = error.localizedDescription
        }
        
        alertsIsLoading = false
    }
    
    @MainActor
    func fetchAirQuality(lat: Double, lon: Double) async {
        airQualityIsLoading = true
        airQualityError = nil
        
        do {
            // Пример API для качества воздуха (замените на реальный)
            guard let url = URL(string: "https://api.example.com/airquality?lat=\(lat)&lon=\(lon)") else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(AirQualityResponse.self, from: data)
            
            self.airQuality = (response.data.aqi, response.data.category)
        } catch {
            // Для демонстрации установим фиктивные данные при ошибке
            self.airQuality = (42, "Moderate")
            airQualityError = error.localizedDescription
        }
        
        airQualityIsLoading = false
    }
    
    @MainActor
    func fetchCurrentConditions(lat: Double, lon: Double) async {
        currentConditionsIsLoading = true
        currentConditionsError = nil
        
        do {
            // Получаем текущие условия с API
            guard let url = URL(string: "https://api.weather.gov/stations/KMSP/observations/latest") else {
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            request.setValue("WeatherApp (you@yourapp.com)", forHTTPHeaderField: "User-Agent")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(CurrentConditionsResponse.self, from: data)
            
            // Преобразуем Цельсий в Фаренгейт
            let tempC = response.properties.temperature.value
            let tempF = (tempC * 9/5) + 32
            
            self.currentConditions = (
                temp: tempF,
                condition: response.properties.weatherCondition,
                humidity: response.properties.humidity.value,
                windSpeed: response.properties.windSpeed.value
            )
        } catch {
            // Для демонстрации установим фиктивные данные при ошибке
            self.currentConditions = (75.0, "Partly Cloudy", 45.0, 10.0)
            currentConditionsError = error.localizedDescription
        }
        
        currentConditionsIsLoading = false
    }
    
    @MainActor
    func fetchRadarMap(lat: Double, lon: Double) async {
        radarMapIsLoading = true
        radarMapError = nil
        
        do {
            // Пример URL для радара (замените на реальный API)
            guard let url = URL(string: "https://api.weather.gov/radar/\(lat),\(lon)") else {
                throw URLError(.badURL)
            }
            
            // Для демонстрации используем фиктивные данные с задержкой
            try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 секунды задержки
            
            self.radarMap = RadarMapData(
                imageURL: URL(string: "https://example.com/radar.png")!,
                timestamp: Date()
            )
        } catch {
            radarMapError = error.localizedDescription
        }
        
        radarMapIsLoading = false
    }
    
    @MainActor
    func fetchLocationName(lat: Double, lon: Double) async {
        locationIsLoading = true
        locationError = nil
        
        do {
            let url = URL(string: "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=\(lat)&lon=\(lon)")!
            
            var request = URLRequest(url: url)
            request.setValue("WeatherApp/1.0", forHTTPHeaderField: "User-Agent")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            
            if let name = json?["display_name"] as? String {
                self.locationName = name
            } else {
                self.locationName = "Unknown Location"
            }
        } catch {
            locationError = error.localizedDescription
        }
        
        locationIsLoading = false
    }
}

extension WeatherViewModel {
    func searchCity(_ city: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.locationError = "❌ \(error.localizedDescription)"
                    self.locationIsLoading = false
                }
                return
            }
            
            if let coordinate = placemarks?.first?.location?.coordinate {
                self.fetchAllWeather(lat: coordinate.latitude, lon: coordinate.longitude)
            } else {
                DispatchQueue.main.async {
                    self.locationError = "❌ Unable to find location"
                    self.locationIsLoading = false
                }
            }
        }
    }
}
