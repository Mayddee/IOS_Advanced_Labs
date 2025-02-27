//
//  UserProfileViewController.swift
//  ProfileManagement
//
//  Created by Амангелди Мадина on 21.02.2025.
//

import Foundation
import UIKit


class UserProfileViewController: UIViewController, ProfileUpdateDelegate, ImageLoaderDelegate  {
    
    var profileManager: ProfileManager?
    var imageLoader: ImageLoader?
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let bioLabel = UILabel()
    
    // Add a property to store the user profile
    var userProfile: UserProfile? {
        didSet {
            // Update the UI when the profile is set
            if let profile = userProfile {
                updateProfile(with: profile)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupProfileManager()
        loadUserProfile()
        
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bioLabel.font = UIFont.systemFont(ofSize: 16)
        bioLabel.numberOfLines = 0
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [profileImageView, nameLabel, bioLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    
    func setupProfileManager() {
        // TODO: Implement setup
        profileManager = ProfileManager(delegate: self)
        
        // Use weak self in closure to prevent retain cycle
        profileManager?.onProfileUpdate = { [weak self] profile in
            self?.updateProfile(with: profile)
        }
    }
    
    func loadUserProfile() {
        profileManager?.loadProfile(id: "user_123") { [weak self] result in
            switch result {
            case .success(let profile):
                self?.updateProfile(with: profile)
            case .failure(let error):
                self?.profileLoadingError(error)
            }
        }
    }
    
    func updateProfile(with profile: UserProfile) {
         // TODO: Implement profile update
         // Consider: How to handle closure capture list?
         nameLabel.text = profile.username
         bioLabel.text = profile.bio
         
         if let url = profile.profileImageURL {
             imageLoader = ImageLoader()
             imageLoader?.delegate = self
             
             imageLoader?.completionHandler = { [weak self] image in
                 self?.profileImageView.image = image ?? UIImage(systemName: "person.crop.circle")
             }
             
             imageLoader?.loadImage(from: url)
         } else {
             profileImageView.image = UIImage(systemName: "person.crop.circle")
         }
     }
     
     
 }

extension UIViewController {
    func profileDidUpdate(_ profile: UserProfile) {
        print("Profile updated: \(profile.username)")
        
    }
    
    func profileLoadingError(_ error: any Error) {
        print("Failed to load profile: \(error.localizedDescription)")
        
    }
    
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage) {
        print("Image loaded via delegate")
        
    }
    
    func imageLoader(_ loader: ImageLoader, didFailWith error: any Error) {
        print("Image loading failed: \(error.localizedDescription)")
        
    }
    
    
}
