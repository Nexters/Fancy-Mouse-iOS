//
//  UIViewController+Extensions.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/17.
//

import UIKit

extension UIViewController {
    func setupNavigationBar() {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        let item = UIBarButtonItem(customView: imageView)
        navigationItem.leftBarButtonItem = item
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray30
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.additionalSafeAreaInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
    }
}
