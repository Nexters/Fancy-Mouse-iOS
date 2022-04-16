//
//  UIViewController+Extensions.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/17.
//

import Toast_Swift
import UIKit

extension UIViewController {
    func setupNavigationTitleImage() {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        let item = UIBarButtonItem(customView: imageView)
        navigationItem.leftBarButtonItem = item
    }
    
    func showToast(message: String, image: UIImage? = nil, position: ToastPosition = .bottom) {
        var style = ToastStyle()
        style.backgroundColor = .gray90.withAlphaComponent(0.9)
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
