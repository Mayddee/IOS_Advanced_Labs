//
//  SceneDelegate.swift
//  HeroRandomizer2
//
//  Created by Амангелди Мадина on 02.03.2025.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
//        let viewModel = ViewModel()
        let rootView = HeroRandomizerView()
        window?.rootViewController = UIHostingController(
            rootView: rootView
        )
        
        window?.makeKeyAndVisible()
    }
    
    


}

