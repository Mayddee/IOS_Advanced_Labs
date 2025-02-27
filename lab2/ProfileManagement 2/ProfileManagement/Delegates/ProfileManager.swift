//
//  ProfileManager.swift
//  ProfileManagement
//
//  Created by Амангелди Мадина on 21.02.2025.
//

import Foundation

protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}

class ProfileManager {
    private var activeProfiles: [String: UserProfile] = [:]
    var delegate: ProfileUpdateDelegate?
    var onProfileUpdate: ((UserProfile) -> Void)?
    
    init(delegate: ProfileUpdateDelegate) {
        self.delegate = delegate
    }
    
    func loadProfile(id: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            let profile = UserProfile(id: id, username: "themaddelina", bio: "thinking", profileImageURL: URL(string: "https://pbs.twimg.com/media/FBkWEFHVkAMRBi7.jpg:large"))
            
            self.activeProfiles[id] = profile
            
            DispatchQueue.main.async {
                completion(.success(profile))
                self.delegate?.profileDidUpdate(profile)
                self.onProfileUpdate?(profile)
            }
        }
    }
}
