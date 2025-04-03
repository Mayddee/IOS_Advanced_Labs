//
//  ImageModel.swift
//  FiveImages
//
//  Created by Амангелди Мадина on 01.04.2025.
//
import Foundation
import SwiftUI

struct ImageModel: Identifiable {
    let id = UUID()
    let image: Image
    let height: CGFloat
}

