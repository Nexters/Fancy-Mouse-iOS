//
//  UIViewController+Extensions.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/17.
//

import Toast_Swift
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
    
    func showToast(message: String, image: UIImage? = nil, position: ToastPosition = .bottom) {
        var style = ToastStyle()
        style.backgroundColor = (.gray90 ?? UIColor.black).withAlphaComponent(0.9)
        style.messageColor = .white
        style.messageFont = .spoqaMedium(size: 14)
        style.cornerRadius = 12
        style.imageSize = CGSize(width: 18, height: 18)
        style.horizontalPadding = 20
        style.verticalPadding = 18

        self.view.makeToast(message, duration: 2, position: position, title: nil,
                            image: image, style: style)
    }
}
