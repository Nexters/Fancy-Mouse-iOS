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
        setupTabBar() 
    }
    
    private func setupTabBar() {
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let homeTitle = "홈"
        let homeImage = UIImage(named: "tab_home_n")
        let homeSelectedImage = UIImage(named: "tab_home_s")?.withRenderingMode(.alwaysOriginal)
        let homeTabBarItem = UITabBarItem(title: homeTitle, image: homeImage,
                                          selectedImage: homeSelectedImage)
        homeViewController.tabBarItem = homeTabBarItem
        
        let wordViewController = HomeViewController()
        let wordTitle = "단어장"
        let wordImage = UIImage(named: "tab_word_n")
        let wordSelectedImage = UIImage(named: "tab_word_s")?.withRenderingMode(.alwaysOriginal)
        let wordTabBarItem = UITabBarItem(title: wordTitle, image: wordImage,
                                          selectedImage: wordSelectedImage)
        wordViewController.tabBarItem = wordTabBarItem
        
        let lerningViewController = HomeViewController()
        let lerningTitle = "학습"
        let lerningImage = UIImage(named: "tab_study_n")
        let lerningSelectedImage = UIImage(named: "tab_study_s")?.withRenderingMode(.alwaysOriginal)
        let lerningTabBarItem = UITabBarItem(title: lerningTitle, image: lerningImage,
                                         selectedImage: lerningSelectedImage)
        lerningViewController.tabBarItem = lerningTabBarItem
        
        let moreViewController = HomeViewController()
        let moreTitle = "더보기"
        let moreImage = UIImage(named: "tab_more_n")
        let moreSelectedImage = UIImage(named: "tab_more_s")?.withRenderingMode(.alwaysOriginal)
        let moreTabBarItem = UITabBarItem(title: moreTitle, image: moreImage,
                                             selectedImage: moreSelectedImage)
        moreViewController.tabBarItem = moreTabBarItem
        
        viewControllers = [homeViewController, wordViewController,
                           lerningViewController, moreViewController]
    }
}
