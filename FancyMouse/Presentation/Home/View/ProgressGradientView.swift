//
//  ProgressGradientView.swift
//  FancyMouse
//
//  Created by betty on 2022/02/23.
//

import Foundation
import UIKit

final class ProgressGradientView: UIView, CAAnimationDelegate {    
    let gradientLayer = CAGradientLayer()
    var startAngle: CGFloat = (-(.pi) / 2)
    var endAngle: CGFloat = 3 * ((.pi) / 2)
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        let startColor = UIColor(red: 225 / 255, green: 255 / 255, blue: 141 / 255, alpha: 1).cgColor
        let endColor = UIColor(red: 103 / 255, green: 118 / 255, blue: 77 / 255, alpha: 1).cgColor
        
        self.gradientLayer.colors = [startColor, endColor]
        self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 0.0, y: 0)
        self.gradientLayer.type = .conic
        self.gradientLayer.frame = rect
        self.layer.addSublayer(self.gradientLayer)
        
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.delegate = self
        
        let path = UIBezierPath(arcCenter: center, radius: 60, startAngle: startAngle, endAngle: endAngle - (.pi / 2), clockwise: true)
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = path.cgPath
        sliceLayer.fillColor = nil
        sliceLayer.lineCap = .round
        sliceLayer.strokeColor = UIColor.black.cgColor
        sliceLayer.lineWidth = 6
        sliceLayer.strokeEnd = 1
        sliceLayer.add(animation, forKey: animation.keyPath)
        
        self.layer.mask = sliceLayer
    }
}
