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
        let image = UIImage(named: "tab_home_n")
        let selectedImage = UIImage(named: "tab_home_s")?.withRenderingMode(.alwaysOriginal)
        let homeTabBarItem = UITabBarItem(title: homeTitle, image: image,
                                          selectedImage: selectedImage)
        homeVC.tabBarItem = homeTabBarItem
        
        let wordVC = HomeViewController()
        let wordTitle = "단어장"
        let wordImage = UIImage(named: "tab_word_n")
        let wordSelectedImage = UIImage(named: "tab_word_s")?.withRenderingMode(.alwaysOriginal)
        let wordTabBarItem = UITabBarItem(title: wordTitle, image: wordImage,
                                          selectedImage: wordSelectedImage)
        wordVC.tabBarItem = wordTabBarItem
        
        let eduVC = HomeViewController()
        let eduTitle = "학습"
        let eduImage = UIImage(named: "tab_study_n")
        let eduSelectedImage = UIImage(named: "tab_study_s")?.withRenderingMode(.alwaysOriginal)
        let eduTabBarItem = UITabBarItem(title: eduTitle, image: eduImage,
                                         selectedImage: eduSelectedImage)
        eduVC.tabBarItem = eduTabBarItem
        
        let profileVC = HomeViewController()
        let profileTitle = "더보기"
        let profileImage = UIImage(named: "tab_more_n")
        let profileSelectedImage = UIImage(named: "tab_more_s")?.withRenderingMode(.alwaysOriginal)
        let profileTabBarItem = UITabBarItem(title: profileTitle, image: profileImage,
                                             selectedImage: profileSelectedImage)
        profileVC.tabBarItem = profileTabBarItem
        
        viewControllers = [homeVC, wordVC, eduVC, profileVC]
    }
}
