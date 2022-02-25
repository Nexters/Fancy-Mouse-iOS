//
//  ProgressGradientView.swift
//  FancyMouse
//
//  Created by betty on 2022/02/23.
//

import Foundation
import UIKit

final class ProgressGradientView: UIView {
    fileprivate var progressLayer = CAShapeLayer()
    
    private var lineWidth: CGFloat = 6 { didSet { setNeedsDisplay(bounds) } }
    private var startColor = UIColor.secondaryColor { didSet { setNeedsDisplay(bounds) } }
    private var endColor = UIColor.gradientEnd { didSet { setNeedsDisplay(bounds) } }
    private var startAngle: CGFloat = -90 { didSet { setNeedsDisplay(bounds) } }
    private var endAngle: CGFloat = 360 { didSet { setNeedsDisplay(bounds) } }

    override func draw(_ rect: CGRect) {
        let gradations = 229
        
        var startColorR: CGFloat = 0
        var startColorG: CGFloat = 0
        var startColorB: CGFloat = 0
        var startColorA: CGFloat = 0
        
        var endColorR: CGFloat = 0
        var endColorG: CGFloat = 0
        var endColorB: CGFloat = 0
        var endColorA: CGFloat = 0

        startColor.getRed(&startColorR,
                          green: &startColorG,
                          blue: &startColorB, alpha: &startColorA)
        endColor.getRed(&endColorR, green: &endColorG,
                        blue: &endColorB, alpha: &endColorA)

        let startAngle: CGFloat = -90
        let endAngle: CGFloat = 180
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        var angle = startAngle

        for index in 1 ... gradations {
            let extraAngle = (endAngle - startAngle) / CGFloat(gradations)
            let currentStartAngle = angle
            let currentEndAngle = currentStartAngle + extraAngle

            let currentR =
            ((endColorR - startColorR) / CGFloat(gradations - 1)) * CGFloat(index - 1) + startColorR
            let currentG =
            ((endColorG - startColorG) / CGFloat(gradations - 1)) * CGFloat(index - 1) + startColorG
            let currentB =
            ((endColorB - startColorB) / CGFloat(gradations - 1)) * CGFloat(index - 1) + startColorB
            let currentA =
            ((endColorA - startColorA) / CGFloat(gradations - 1)) * CGFloat(index - 1) + startColorA

            let currentColor = UIColor.init(red: currentR, green: currentG,
                                            blue: currentB, alpha: currentA)

            let path = UIBezierPath()
            path.lineWidth = lineWidth
            path.lineCapStyle = .round
            path.addArc(withCenter: center,
                        radius: radius,
                        startAngle: currentStartAngle * CGFloat(Double.pi / 180.0),
                        endAngle: currentEndAngle * CGFloat(Double.pi / 180.0),
                        clockwise: true)
            currentColor.setStroke()
            path.stroke()
            angle = currentEndAngle
        }
    }
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateprogress")
    }
}
