//
//  PostView.swift
//  ProfileManagement
//
//  Created by Амангелди Мадина on 21.02.2025.
//

import Foundation
import UIKit

class PostView: UITableViewCell, ImageLoaderDelegate {
    static let identifier = "PostCell"
    
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let contentLabel = UILabel()
    private let hashtagsLabel = UILabel()
    private var imageLoader: ImageLoader?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        usernameLabel.font = .boldSystemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        hashtagsLabel.font = .systemFont(ofSize: 12)
        hashtagsLabel.textColor = .gray
        
        let contentStack = UIStackView(arrangedSubviews: [usernameLabel, contentLabel, hashtagsLabel])
        contentStack.axis = .vertical
        contentStack.spacing = 4
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        let containerStack = UIStackView(arrangedSubviews: [profileImageView, contentStack])
        containerStack.axis = .horizontal
        containerStack.spacing = 12
        containerStack.alignment = .top
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(containerStack)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with post: Post) {
        usernameLabel.text = "@\(post.author.username)"
        contentLabel.text = post.content
        hashtagsLabel.text = post.hashtags.map { "#\($0)" }.joined(separator: " ")
        
        if let url = post.author.profileImageURL {
            imageLoader = ImageLoader()
            imageLoader?.delegate = self
            imageLoader?.loadImage(from: url)
        } else {
            profileImageView.image = UIImage(systemName: "person.circle")
        }
    }

    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage) {
        profileImageView.image = image
    }
    
    func imageLoader(_ loader: ImageLoader, didFailWith error: any Error) {
        print("Failed to load image: \(error.localizedDescription)")
        profileImageView.image = UIImage(systemName: "person.circle")
    }
}

