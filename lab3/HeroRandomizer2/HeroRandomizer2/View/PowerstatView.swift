//
//  PowerstatView.swift
//  HeroRandomizer2
//
//  Created by Амангелди Мадина on 06.03.2025.
//
import Foundation
import SwiftUI

struct PowerstatView: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(value)
                .font(.caption)
                .bold()
            Text(label)
                .font(.caption2)
        }
        .frame(width: 60)
    }
}
