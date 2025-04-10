//
//  AlertSection.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import SwiftUI

struct AlertsSection: View {
    var alerts: [WeatherAlert]
    var isLoading: Bool
    var error: String?
    
    var body: some View {
        VStack {
            if !alerts.isEmpty || isLoading || error != nil {
                Text("Weather Alerts")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.red)
                
                if isLoading {
                    LoadingErrorView(isLoading: true, error: nil, retryAction: {})
                        .frame(height: 100)
                } else if let errorMessage = error {
                    LoadingErrorView(isLoading: false, error: errorMessage, retryAction: {})
                        .frame(height: 100)
                } else if alerts.isEmpty {
                    Text("No active alerts")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else {
                    ForEach(alerts) { alert in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(alert.title)
                                .font(.headline)
                                .foregroundColor(.red)
                            
                            Text(alert.description)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(3)
                        }
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
}


//#Preview {
//    AlertSection()
//}
