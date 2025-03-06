//
//  SuperheroCardView.swift
//  HeroRandomizer2
//
//  Created by Амангелди Мадина on 06.03.2025.
//
import Foundation
import SwiftUI

struct SuperheroCardView: View {
    let superhero: Superhero
    
    var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                if let imageUrl = superhero.images?.md, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)//размер контента и пропорция
                            .frame(height: 180)
                            .clipped()//располагается внутрь рамки
                    } placeholder: {
                        ProgressView()
                            .frame(height: 180)
                    }
                }
                
                Text(superhero.name)
                    .font(.title2)
                    .bold()
                
                if let fullName = superhero.biography?.fullName, !fullName.isEmpty {
                    Text("Full Name: \(fullName)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
 
                HStack {
                    if let power = superhero.powerstats?.power {
                        PowerstatView(icon: "bolt.circle.fill", label: "Power", value: "\(power)")
                    }
                    if let intelligence = superhero.powerstats?.intelligence {
                        PowerstatView(icon: "lightbulb.fill", label: "Intelligence", value: "\(intelligence)")
                    }
                    if let strength = superhero.powerstats?.strength {
                        PowerstatView(icon: "figure.strengthtraining.traditional", label: "Strength", value: "\(strength)")
                    }
                    if let speed = superhero.powerstats?.speed {
                        PowerstatView(icon: "speedometer", label: "Speed", value: "\(speed)")
                    }
                }
                
                

                if let firstAppearance = superhero.biography?.firstAppearance, !firstAppearance.isEmpty {
                    Text("First Appearance: \(firstAppearance)")
                        .font(.subheadline)
                }
                
                if let publisher = superhero.biography?.publisher, !publisher.isEmpty {
                    Text("Publisher: \(publisher)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                
                if let base = superhero.work?.base, !base.isEmpty {
                    Text("Base: \(base)")
                        .font(.subheadline)
                        .italic()
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(Rectangle())
            .shadow(radius: 1)
            .padding(.horizontal)
        }
}

//#Preview {
//    SuperheroCardView()
//}
