//
//  MainTabBarController.swift
//  ProfileManagement
//
//  Created by Амангелди Мадина on 21.02.2025.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {


    override func viewDidLoad() {
        let profile = UserProfileViewController()
        let feed = FeedViewController()
        super.viewDidLoad()
        


        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 0)
        feed.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.circle"), tag: 1)
        
        
        let profileNav = UINavigationController(rootViewController: profile)
        let feedNav = UINavigationController(rootViewController: feed)


        
        viewControllers = [feedNav, profileNav]
    }
}

