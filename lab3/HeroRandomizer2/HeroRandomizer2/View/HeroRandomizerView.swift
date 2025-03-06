//
//  HeroRandomizerView.swift
//  HeroRandomizer2
//
//  Created by Амангелди Мадина on 02.03.2025.
//

import SwiftUI

struct HeroRandomizerView: View {
    @StateObject var viewmodel = SuperherosViewModel()
    var body: some View {

        
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewmodel.randomSuperheros ?? [], id: \.id) { superhero in
                            SuperheroCardView(superhero: superhero)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }

                Spacer()
                Button {
                    Task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        await viewmodel.fetchRandomSuperheroes()
                    }
                } label: {
                    Text("Roll Hero")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Superheroes")
            .task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                await viewmodel.fetchRandomSuperheroes()
            }
        }
                   
    }
}
    


#Preview {
    HeroRandomizerView()
}
