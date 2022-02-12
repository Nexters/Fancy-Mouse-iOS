//
//  TestTabbarViewController.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/12.
//

import UIKit

class TestTabbarViewController: UITabBarController {
    let vc1: HomeViewController = {
        let homeVC = HomeViewController()
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
