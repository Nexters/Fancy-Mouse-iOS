//
//  WordMeaningsStackView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/16.
//

import UIKit

final class WordMeaningsStackView: UIStackView {
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubMeaningViews(with meanings: [String]) {
        subviews.forEach {
            $0.removeFromSuperview()
        }
        meanings.enumerated().forEach { index, meaning in
            addSubMeaningView(index: index + 1, meaning: meaning)
        }
    }
}
    
private extension WordMeaningsStackView {
    func setup() {
        axis = .vertical
        distribution = .equalSpacing
        alignment = .fill
        spacing = 6
    }
    
    func addSubMeaningView(index: Int, meaning: String) {
        let meaningView = WordMeaningView()
        meaningView.index = index
        meaningView.meaning = meaning
        meaningView.meaningLineNumber = 1
        
        addArrangedSubview(meaningView)
    }
}
