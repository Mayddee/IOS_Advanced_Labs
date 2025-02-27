//
//  FeedViewController.swift
//  ProfileManagement
//
//  Created by Амангелди Мадина on 21.02.2025.
//

import Foundation
import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let feedSystem = FeedSystem()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSamplePosts()
    }

    private func setupUI() {
        title = "Feed"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostView.self, forCellReuseIdentifier: PostView.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadSamplePosts() {
        let user1 = UserProfile(id: "1", username: "lovely_runner", bio: "...", profileImageURL: URL(string: "https://media.california.com/media/_versions_jpg/articles/shutterstock_633629336__1000x637____v1222x580__.jpg"))
        let user2 = UserProfile(id: "2", username: "asselya_", bio: "Just blogger", profileImageURL: URL(string: "https://www.njlifestylemag.com/content/images/size/w1304/2023/12/AdobeStock_267334945.jpeg"))
        let user3 = UserProfile(id: "3", username: "kittycat", bio: "Cutie cat", profileImageURL: URL(string: "https://i.redd.it/rbejrmzqy4s61.jpg"))
        let user4 = UserProfile(id: "4", username: "mayddee", bio: "Another World", profileImageURL: URL(string: "https://aphrodite.gmanetwork.com/imagefiles/1000/1560504972_156355900_17_ent.jpg"))

        let post1 = Post(id: UUID(), author: user1, hashtags: ["kdrama", "lovely_runner", "sungjae"], content: "Watching Lovely Runner again hehehehe")
        let post2 = Post(id: UUID(), author: user2, hashtags: ["hollywood", "LA"], content: "Walking in LA downtown!")
        let post3 = Post(id: UUID(), author: user3, hashtags: ["art", "picture"], content: "Рисую ночью картину ")
        let post4 = Post(id: UUID(), author: user4, hashtags: ["coding"], content: "Coding again and nothing else... Yeaaah")

        feedSystem.addPost(post1)
        feedSystem.addPost(post2)
        feedSystem.addPost(post3)
        feedSystem.addPost(post4)
        
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedSystem.getPosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostView.identifier, for: indexPath) as? PostView else {
            return UITableViewCell()
        }
        let post = feedSystem.getPosts()[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
