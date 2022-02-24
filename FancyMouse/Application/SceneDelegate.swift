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
        
//        let viewController = HomeViewController()
//        let viewController = FolderViewController()
        let viewController = TestTabbarViewController()
//        let viewController = UINavigationController(rootViewController: FolderViewController())
        window?.rootViewController = viewController
    }
}
import UIKit

class TestTabbarViewController: UITabBarController {
    let vc1: FolderViewController = {
        let homeVC = FolderViewController()
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: nil, tag: 0)
        homeVC.navigationItem.largeTitleDisplayMode = .always
        return homeVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarLink()
    }
    
    private func setTabBarLink() {
        let nav1 = UINavigationController(rootViewController: vc1)
        setViewControllers([nav1], animated: false)
    }
}
