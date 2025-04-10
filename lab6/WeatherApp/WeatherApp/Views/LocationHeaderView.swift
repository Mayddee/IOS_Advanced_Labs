//
//  LocationHeaderView.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import SwiftUI

struct LocationHeaderView: View {
    var locationName: String
    var isLoading: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundColor(.blue)
                .font(.headline)
            
            if isLoading {
                Text("Определение местоположения...")
                    .font(.headline)
                    .foregroundColor(.secondary)
                ProgressView()
                    .scaleEffect(0.7)
            } else {
                Text(formatLocationName(locationName))
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private func formatLocationName(_ name: String) -> String {
        let components = name.components(separatedBy: ", ")
        if components.count > 2 {
            return components.first! + ", " + components.last!
        }
        return name
    }
}

//#Preview {
//    LocationHeaderView()
//}
