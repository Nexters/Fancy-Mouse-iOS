//
//  TabBarController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/01.
//

import SwiftUI
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarColor()
        setupTabBar() 
    }
    
    private func setupTabBarColor() {
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.spoqaMedium(size: 11)],
            for: .normal
        )
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.spoqaMedium(size: 11)],
            for: .selected
        )
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.gray50],
            for: .normal
        )
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.primaryColor],
            for: .selected
        )
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        tabBar.layer.applyShadow(color: .gray40, alpha: 0.16, xValue: 0, yValue: -8, blur: 16, spread: 0)
        tabBar.barTintColor = .white
        tabBar.isTranslucent = true
    }
    
    private func setupTabBar() {
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let homeTitle = "홈"
        let homeImage = UIImage(named: "tab_home_n")?.withRenderingMode(.alwaysOriginal)
        let homeSelectedImage = UIImage(named: "tab_home_s")?.withRenderingMode(.alwaysOriginal)
        let homeTabBarItem = UITabBarItem(title: homeTitle, image: homeImage,
                                          selectedImage: homeSelectedImage)
        homeViewController.tabBarItem = homeTabBarItem
        
        let wordViewController = UINavigationController(rootViewController: FolderViewController())
        let wordTitle = "단어장"
        let wordImage = UIImage(named: "tab_word_n")?.withRenderingMode(.alwaysOriginal)
        let wordSelectedImage = UIImage(named: "tab_word_s")?.withRenderingMode(.alwaysOriginal)
        let wordTabBarItem = UITabBarItem(title: wordTitle, image: wordImage,
                                          selectedImage: wordSelectedImage)
        wordViewController.tabBarItem = wordTabBarItem
        
        let lerningViewController = UIHostingController(rootView:
                                                        LearningView().environmentObject(LearningViewModel()))
        let lerningTitle = "학습"
        let lerningImage = UIImage(named: "tab_study_n")?.withRenderingMode(.alwaysOriginal)
        let lerningSelectedImage = UIImage(named: "tab_study_s")?.withRenderingMode(.alwaysOriginal)
        let lerningTabBarItem = UITabBarItem(title: lerningTitle, image: lerningImage,
                                             selectedImage: lerningSelectedImage)
        lerningViewController.tabBarItem = lerningTabBarItem
        
        let moreViewController = UIHostingController(rootView: MoreView())
        let moreTitle = "더보기"
        let moreImage = UIImage(named: "tab_more_n")?.withRenderingMode(.alwaysOriginal)
        let moreSelectedImage = UIImage(named: "tab_more_s")?.withRenderingMode(.alwaysOriginal)
        let moreTabBarItem = UITabBarItem(title: moreTitle, image: moreImage,
                                          selectedImage: moreSelectedImage)
        moreViewController.tabBarItem = moreTabBarItem
        
        viewControllers = [homeViewController, wordViewController,
                           lerningViewController, moreViewController]
    }
}
