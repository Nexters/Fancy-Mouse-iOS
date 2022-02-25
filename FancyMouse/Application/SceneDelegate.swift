//
//  SceneDelegate.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let viewController = UINavigationController(rootViewController: TabBarController())
        window?.rootViewController = viewController
    }
}
