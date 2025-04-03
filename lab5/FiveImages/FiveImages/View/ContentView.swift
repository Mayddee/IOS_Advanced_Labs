//
//  ContentView.swift
//  FiveImages
//
//  Created by Arman Myrzakanurov on 28.03.2025.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ImagesViewModel()

        var body: some View {
            NavigationView {
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .padding(.top)
                    }

                    GridView(images: viewModel.images, spacing: 10)
                    Button(action: {
                        viewModel.getImages() 
                    }) {
                        Text("Load More Images")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.top)
                    }

                    
                }
                .navigationTitle("Pinterest View")
                .padding()
            }
        }
   
}

#Preview {
    ContentView()
}
