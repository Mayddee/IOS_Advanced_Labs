//
//  LoadingErrorView.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import SwiftUI

struct LoadingErrorView: View {
    var isLoading: Bool
    var error: String?
    var retryAction: () -> Void
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
                Text("Loading...")
                    .foregroundColor(.secondary)
            } else if let errorMessage = error {
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.title)
                        .foregroundColor(.orange)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    Button("Try Again") {
                        retryAction()
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
        }
    }
}

//#Preview {
//    LoadingErrorView()
//}
