//
//  HeroDetailsView.swift
//  HeroApp
//
//  Created by Амангелди Мадина on 20.03.2025.
//

import SwiftUI

struct HeroDetailsView: View {
    @StateObject var viewModel: HeroDetailsViewModel

    var body: some View {
        ZStack {
            backgroundView()

            content()
        }
        .task {
            await viewModel.fetchHeroDetails()
        }
    }

    @ViewBuilder
    private func content() -> some View {
        if let hero = viewModel.hero {
            heroDetailsView(hero)
        } else if let errorMessage = viewModel.errorMessage {
            errorView(message: errorMessage)
        } else {
            loadingView()
        }
    }

    @ViewBuilder
    private func backgroundView() -> some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                       startPoint: .top,
                       endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }

    private func heroDetailsView(_ hero: HeroDetailsModel) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                heroImageView(hero.heroImage)
                heroInfoCard(hero)
            }
        }
    }

    private func heroImageView(_ imageUrl: URL?) -> some View {
        Group {
            if let imageUrl = imageUrl {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)
                    default:
                        ProgressView()
                    }
                }
            }
        }
    }

    private func heroInfoCard(_ hero: HeroDetailsModel) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(hero.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            infoRow(label: "Race", value: hero.race, icon: "person.fill")
            infoRow(label: "Biography", value: hero.biography, icon: "book.fill")
            Divider().background(Color.white)

            Text("Power Stats")
                .font(.headline)
                .foregroundColor(.white)
            powerStatsView(hero.powerstats)
        }
        .padding()
        .background(Color.black.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
        .padding()
    }

    private func powerStatsView(_ powerstats: [String: Int]) -> some View {
        VStack(spacing: 10) {
            ForEach(powerstats.sorted(by: >), id: \.key) { key, value in
                HStack {
                    Image(systemName: getStatIcon(for: key))
                        .foregroundColor(.yellow)
                        .font(.title2)
                    
                    Text("\(key.capitalized):")
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(value)")
                        .foregroundColor(.yellow)
                        .font(.title3)
                        .bold()
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }

    private func infoRow(label: String, value: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.yellow)
            Text("\(label):")
                .bold()
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .foregroundColor(.white.opacity(0.8))
        }
    }

    private func getStatIcon(for stat: String) -> String {
        switch stat.lowercased() {
        case "strength": return "bolt.fill"
        case "speed": return "hare.fill"
        case "intelligence": return "brain.head.profile"
        case "power": return "flame.fill"
        case "durability": return "shield.fill"
        default: return "star.fill"
        }
    }

    private func errorView(message: String) -> some View {
        VStack {
            Text("Error")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            Text(message)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
        .background(Color.red.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
    }

    private func loadingView() -> some View {
        VStack {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
        }
    }
}
