//
//  SuperheroModel.swift
//  HeroRandomizer2
//
//  Created by Амангелди Мадина on 02.03.2025.
//
import Foundation

struct Superhero: Decodable, Hashable {
    let id: Int
    let name: String
    let powerstats: Powerstats?
    let appearance: Appearance?
    let biography: Biography?
    let work: Work?
    let connections: Connections?
    let images: Images?
    static func == (lhs: Superhero, rhs: Superhero) -> Bool {
           return lhs.id == rhs.id
       }
       func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(name)
       }
}

struct Powerstats: Decodable {
    var intelligence: Int?
    var strength: Int?
    var speed: Int?
    var durability: Int?
    var power: Int?
    var combat: Int?
}

struct Appearance: Decodable {
    let gender: String?
    let race: String?
    let height: [String]?
    let weight: [String]?
    let eyeColor: String?
    let hairColor: String?
}

struct Biography: Decodable {
    let fullName: String?
    let alterEgos: String?
    let aliases: [String]?
    let placeOfBirth: String?
    let firstAppearance: String?
    let publisher: String?
    let alignment: String?
    
}

struct Work: Decodable {
    let occupation: String?
    let base: String?
}

struct Connections: Decodable {
    let groupAffiliation: String?
    let relatives: String?
}

struct Images: Decodable {
    var xs: String?
    var sm: String?
    var md: String?
    var lg: String?
}

