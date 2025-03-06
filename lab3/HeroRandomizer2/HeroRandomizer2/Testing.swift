//
//  Testing.swift
//  HeroRandomizer2
//
//  Created by Амангелди Мадина on 03.03.2025.
//
import Foundation

//just to test fetchRandomSuperheroes
//@main
class Testing {
    static func main() async throws -> Void {
        
        await testRandomheroes()
    }
    
    static func testRandomheroes() async {
        print("\n Тест: fetchRandomSuperheroes()")
        let vm = SuperherosViewModel()

        await vm.fetchRandomSuperheroes()

        if let randomHeroes = vm.randomSuperheros {
            print("Test Passed: Random heroes count is \(randomHeroes.count)")
            assert(randomHeroes.count == 10, "Test Failed")

            // Print the names of the randomly fetched superheroes
            print("Random Superheroes:")
            for hero in randomHeroes {
                print("- \(hero.name)")
            }
        } else {
            print("RandomSuperheros is nil")
        }
    }
}
