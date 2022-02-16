//
//  WordMeaningsStackView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/16.
//

import UIKit

final class WordMeaningsStackView: UIStackView {
    func addSubMeaningViews(with meanings: [String]) {
        meanings.enumerated().forEach { index, meaning in
            addSubMeaningView(index: index + 1, meaning: meaning)
        }
    }
    
    private func addSubMeaningView(index: Int, meaning: String) {
        let meaningView = WordMeaningView()
        meaningView.index = index
        meaningView.meaning = meaning
        meaningView.translatesAutoresizingMaskIntoConstraints = false
        
        addArrangedSubview(meaningView)
    }
}
