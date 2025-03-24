//
//  HeroDetailsModel.swift
//  HeroApp
//
//  Created by Амангелди Мадина on 20.03.2025.
//
import Foundation

struct HeroDetailsModel: Identifiable {
    let id: Int
    let name: String
    let race: String
    let heroImage: URL?
    let biography: String
    let powerstats: [String: Int]
    let publisher: String
    let occupation: String
    let base: String
}
