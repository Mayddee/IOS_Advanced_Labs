//
//  FeedSystem.swift
//  ProfileManagement
//
//  Created by Амангелди Мадина on 21.02.2025.
//

import Foundation


// MARK: - Protocol for Feed Updates
protocol FeedUpdateDelegate: AnyObject {
    func didUpdateFeed(_ feed: [Post])
    func didFailToUpdateFeed(with error: Error)
}

// MARK: - Feed System
class FeedSystem {
    private var userCache: [String: UserProfile] = [:]
    private var feedPosts: [Post] = []
    private var hashtags: Set<String> = []

    func addPost(_ post: Post) {
        feedPosts.insert(post, at: 0) 
        userCache[post.author.id] = post.author
        hashtags.formUnion(post.hashtags)
    }

    func removePost(_ post: Post) {
        if let index = feedPosts.firstIndex(of: post) {
            feedPosts.remove(at: index)
        }
    }

    func getPosts() -> [Post] {
        return feedPosts
    }
}
