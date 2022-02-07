//
//  UIFont+Extensions.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/06.
//

import UIKit

extension UIFont {
    static func spoqaRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "SpoqaHanSansNeo-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func spoqaMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "SpoqaHanSansNeo-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func spoqaBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SpoqaHanSansNeo-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
