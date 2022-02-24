//
//  CALayer+Extensions.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/25.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = .gray40,
        alpha: Float = 0.2,
        xValue: CGFloat = 0,
        yValue: CGFloat = 4,
        blur: CGFloat = 30,
        spread: CGFloat = 0
    ) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: xValue, height: yValue)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dxValue = -spread
            let rect = bounds.insetBy(dx: dxValue, dy: dxValue)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
