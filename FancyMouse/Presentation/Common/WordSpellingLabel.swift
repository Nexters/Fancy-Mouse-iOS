//
//  WordSpellingLabel.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/16.
//

import UIKit

final class WordSpellingLabel: UILabel {
    init() {
        super.init(frame: .zero)
        
        textColor = .gray90
        font = .spoqaBold(size: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
