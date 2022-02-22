//
//  AttributedTextBuilder.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/21.
//

import UIKit

protocol BuilderType {
    associatedtype Product
    
    func build() -> Product
}

extension NSMutableAttributedString {
    typealias Builder = AttributedTextBuilder
}

class AttributedTextBuilder: BuilderType {
    private var text: String?
    private var paragraphStyle: NSMutableParagraphStyle?
    private var backgroundColor: UIColor?
    private var foregroundColor: UIColor?
    private var font: UIFont?
    private var range: NSRange?
    
    func withString(_ text: String) -> AttributedTextBuilder {
        self.text = text
        return self
    }
    
    func withBackgroundColor(_ color: UIColor?) -> AttributedTextBuilder {
        backgroundColor = color
        return self
    }
    
    func withForegroundColor(_ color: UIColor?) -> AttributedTextBuilder {
        foregroundColor = color
        return self
    }
    
    func withLineSpacing(_ spacing: Int?) -> AttributedTextBuilder {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = CGFloat(spacing ?? 0)
        paragraphStyle = style
        return self
    }
    
    func withFont(_ font: UIFont?) -> AttributedTextBuilder {
        self.font = font
        return self
    }
    
    func withRange(from: String, end: String) -> AttributedTextBuilder {
        let range = (from as NSString).range(of: end)
        self.range = range
        return self
    }
    
    func build() -> NSMutableAttributedString {
        guard let text = self.text, let range = self.range else {
            return NSMutableAttributedString()
        }
        let attributedString = NSMutableAttributedString(string: text)
        
        if let color = backgroundColor {
            attributedString.addAttribute(
                .backgroundColor,
                value: color,
                range: range
            )
        }
        
        if let color = foregroundColor {
            attributedString.addAttribute(
                .foregroundColor,
                value: color,
                range: range
            )
        }
        
        if let font = self.font {
            attributedString.addAttribute(
                .font,
                value: font,
                range: range
            )
        }
        
        if let paragraphStyle = paragraphStyle {
            attributedString.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: (text as NSString).range(of: text)
            )
        }
        
        return attributedString
    }
}
