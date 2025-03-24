//
//  HeroDetailsViewModel.swift
//  HeroApp
//
//  Created by Амангелди Мадина on 20.03.2025.
//
import Foundation
import SwiftUI

final class HeroDetailsViewModel: ObservableObject {
        private let service: HeroService
        private let heroId: Int

        @Published var hero: HeroDetailsModel?
        @Published var errorMessage: String?

        init(service: HeroService, heroId: Int) {
            self.service = service
            self.heroId = heroId
        }

        func fetchHeroDetails() async {
            do {
                let heroes = try await service.fetchHeroes()
                if let foundHero = heroes.first(where: { $0.id == heroId }) {
                    await MainActor.run {
                        self.hero = HeroDetailsModel(
                            id: foundHero.id,
                            name: foundHero.name,
                            race: foundHero.appearance.race ?? "Unknown",
                            heroImage: foundHero.heroImageUrl,
                            biography: foundHero.biography.fullName ?? "No biography",
                            powerstats: [
                                "Intelligence": foundHero.powerstats.intelligence ?? 0,
                                "Strength": foundHero.powerstats.strength ?? 0,
                                "Speed": foundHero.powerstats.speed ?? 0,
                                "Durability": foundHero.powerstats.durability ?? 0,
                                "Power": foundHero.powerstats.power ?? 0,
                                "Combat": foundHero.powerstats.combat ?? 0
                            ],
                            publisher: foundHero.biography.publisher ?? "Unknown",
                            occupation: foundHero.work.occupation ?? "Unknown",
                            base: foundHero.work.base ?? "Unknown"
                        )
                    }
                } else {
                    await MainActor.run {
                        errorMessage = "Hero not found."
                    }
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Failed to load hero details: \(error.localizedDescription)"
                }
            }
        }
}
