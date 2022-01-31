//
//  TabBarController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/01.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let homeTitle = "홈"
        let image = UIImage(named: "Home-1")
        let selectedImage = UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal)
        let homeTabBarItem = UITabBarItem(title: homeTitle, image: image,
                                          selectedImage: selectedImage)
        homeVC.tabBarItem = homeTabBarItem
        
        let wordVC = HomeViewController()
        let wordTitle = "단어장"
        let wordImage = UIImage(named: "Arhive")
        let wordSelectedImage = UIImage(named: "Arhive_fill")?.withRenderingMode(.alwaysOriginal)
        let wordTabBarItem = UITabBarItem(title: wordTitle, image: wordImage,
                                          selectedImage: wordSelectedImage)
        wordVC.tabBarItem = wordTabBarItem
        
        let eduVC = HomeViewController()
        let eduTitle = "학습장"
        let eduImage = UIImage(named: "notFill_book")
        let eduSelectedImage = UIImage(named: "Fill_book")?.withRenderingMode(.alwaysOriginal)
        let eduTabBarItem = UITabBarItem(title: eduTitle, image: eduImage,
                                         selectedImage: eduSelectedImage)
        eduVC.tabBarItem = eduTabBarItem
        
        let profileVC = HomeViewController()
        let profileTitle = "마이페이지"
        let profileImage = UIImage(named: "User")
        let profileSelectedImage = UIImage(named: "User_fill")?.withRenderingMode(.alwaysOriginal)
        let profileTabBarItem = UITabBarItem(title: profileTitle, image: profileImage,
                                             selectedImage: profileSelectedImage)
        profileVC.tabBarItem = profileTabBarItem
        
        viewControllers = [homeVC, wordVC, eduVC, profileVC]
    }
}
