//
//  AlertModel.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import Foundation

struct AlertResponse: Codable {
    let features: [AlertFeature]
}

struct AlertFeature: Codable, Identifiable {
    let id: String
    let properties: AlertProperties
}

struct AlertProperties: Codable {
    let headline: String
    let description: String
}

struct WeatherAlert: Identifiable {
    let id: String
    let title: String
    let description: String
}

struct AirQualityResponse: Codable {
    let data: AQIData
}

struct AQIData: Codable {
    let aqi: Int
    let category: String
}

struct CurrentConditionsResponse: Codable {
    let properties: CurrentProperties
}

struct CurrentProperties: Codable {
    let temperature: Temperature
    let windSpeed: WindSpeed
    let humidity: Humidity
    let weatherCondition: String
    
    enum CodingKeys: String, CodingKey {
        case temperature
        case windSpeed
        case humidity = "relativeHumidity"
        case weatherCondition = "textDescription"
    }
}

struct Temperature: Codable {
    let value: Double
    let unitCode: String
}

struct WindSpeed: Codable {
    let value: Double
    let unitCode: String
}

struct Humidity: Codable {
    let value: Double
}

struct RadarMapData: Identifiable {
    let id = UUID()
    let imageURL: URL
    let timestamp: Date
}
