//
//  GridView.swift
//  FiveImages
//
//  Created by Амангелди Мадина on 01.04.2025.
//

import SwiftUI

struct GridView: View {
    let images: [ImageModel]
        let spacing: CGFloat
        
        private var columns: Int {
            let screenWidth = UIScreen.main.bounds.width
            if screenWidth < 375 {
                return 2
            } else {
                return 3
            }
        }
        
        var body: some View {
            GeometryReader { geometry in
                ScrollView {
                    let width = (geometry.size.width / CGFloat(columns)) - (spacing * 2)
                    
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns),
                        spacing: spacing // to ensure equal spacing between rows
                    ) {
                        ForEach(images) { model in
                            model.image
                                .resizable()
                                .scaledToFill()
                                .frame(width: width, height: model.height) 
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 4)
                                .padding(.bottom, spacing)
                        }
                    }
                    .padding(.horizontal, spacing)
                }
            }
        }
}
