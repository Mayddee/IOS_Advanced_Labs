//
//  SuperheroViewModel.swift
//  HeroRandomizer2
//
//  Created by Амангелди Мадина on 02.03.2025.
//

import Foundation

class SuperherosViewModel: ObservableObject { //лучше класс так как классы поддерживают изменение свойств внутри escaping-замыканий ведь superheros у нас var
    var service  = SuperheroService()
//    private(set) var superheros: [Superhero]?
    @Published var randomSuperheros: [Superhero]?
    
       

        // MARK: - Methods
    func fetchHero(superheroes: [Superhero]) async -> Superhero? {
            
            
            if let randomHero = superheroes.randomElement() {
                return randomHero
            }
            
            return nil
                    
        }
        
       
    func fetchRandomSuperheroes() async  {
        var service = SuperheroService()
        do {
            print("🌍 Запрос отправляется...")
            var superheroes = try await service.fetchSuperheroes()
            if superheroes.count < 10  {
                    print("Not enough superheroes available!")
                    return
            }

            await MainActor.run {
                self.randomSuperheros = Array(superheroes.shuffled().prefix(10)) // Pick 10 random heroes
            }

        } catch {
            print("Ошибка при загрузке супергероев: \(error)")
        }

        
        
       
   
        
    }
}

