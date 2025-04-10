//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import Foundation

struct ForecastResponse: Codable {
    let properties: ForecastProperties
}

struct ForecastProperties: Codable {
    let periods: [ForecastPeriod]
}

struct ForecastPeriod: Codable, Identifiable {
    let id = UUID()
    let name: String
    let temperature: Int
    let temperatureUnit: String
    let shortForecast: String
    let detailedForecast: String
    let icon: String?
}
