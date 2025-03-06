//
//  SuperheroService.swift
//  HeroRandomizer2
//
//  Created by Амангелди Мадина on 02.03.2025.
//
import Foundation
struct Constraints {
    static let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json")
}


struct SuperheroService{
    
    
    func fetchSuperheroes() async throws -> [Superhero] {
        guard let url = Constraints.url else {
               print("Invalid URL")
               return []
        }
        let urlRequest = URLRequest(url: url)

           let (data, response) = try await URLSession.shared.data(for: urlRequest)
           print("Response:", response)

           if let jsonString = String(data: data, encoding: .utf8) {
               print("JSON Response (first 500 chars):\n\(jsonString.prefix(500))...")
           } else {
               print("No JSON received")
           }

           do {
               let decoder = JSONDecoder()
               return try decoder.decode([Superhero].self, from: data)
           } catch {
               print("Ошибка при декодировании: \(error.localizedDescription)")
               return []
           }
       }
    

}
