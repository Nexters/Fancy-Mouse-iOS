//
//  WordSpellingLabel.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/16.
//

import UIKit

protocol Hidable: AnyObject {
    func hide()
    func show()
}

final class WordSpellingLabel: UILabel {
    init() {
        super.init(frame: .zero)
        
        font = .spoqaBold(size: 20)
        layer.cornerRadius = 8
        
        setupDefaultViewColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDefaultViewColor() {
        textColor = .gray90
        backgroundColor = .clear
    }
}

extension WordSpellingLabel: Hidable {
    func hide() {
        textColor = .gray30
        backgroundColor = .gray30
    }
    
    func show() {
        setupDefaultViewColor()
    }
}
