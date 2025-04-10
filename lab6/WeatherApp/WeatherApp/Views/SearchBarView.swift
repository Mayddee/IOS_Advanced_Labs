//
//  SearchBarView.swift
//  WeatherApp
//
//  Created by Амангелди Мадина on 09.04.2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var citySearch: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("Enter city name", text: $citySearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onSubmit {
                    onSearch()
                }
            
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .padding()
            }
        }
    }
}

//#Preview {
//    SearchBarView()
//}
