//
//  NetworkCashe.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//
import Foundation
import SwiftUI

class NetworkCache {
    static let shared = NetworkCache()
    private let cache = NSCache<NSString, NSData>()
    private init() {}
    
    func saveData(_ data: Data, forKey key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func loadData(forKey key: String) -> Data? {
        cache.object(forKey: key as NSString) as Data?
    }
}

