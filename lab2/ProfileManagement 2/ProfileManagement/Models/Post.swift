//
//  Post.swift
//  ProfileManagement
//
//  Created by Амангелди Мадина on 21.02.2025.
//

import Foundation
import UIKit

struct Post: Hashable {
    let id: UUID
    let author: UserProfile
    var hashtags: [String]
    var content: String
       
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
}
