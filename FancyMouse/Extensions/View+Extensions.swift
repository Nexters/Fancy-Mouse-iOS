//
//  View+Extensions.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/13.
//

import SwiftUI

extension View {
    func spoqaRegular(size: CGFloat) -> some View {
        self.font(Font.custom("SpoqaHanSansNeo-Regular", size: size))
    }
    
    func spoqaMedium(size: CGFloat) -> some View {
        self.font(Font.custom("SpoqaHanSansNeo-Medium", size: size))
    }
    
    func spoqaBold(size: CGFloat) -> some View {
        self.font(Font.custom("SpoqaHanSansNeo-Bold", size: size))
    }
}
