//
//  WordMeaningView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/16.
//

import UIKit

final class WordMeaningView: UIView {
    private let indexLabel = UILabel()
    private let meaningLabel = UILabel()
    
    var index: Int? {
        didSet {
            indexLabel.text = "\(index ?? 0)."
        }
    }
    
    var meaning: String? {
        didSet {
            let attributedString = NSMutableAttributedString(string: meaning ?? "")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            attributedString.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: paragraphStyle,
                range: NSRange(location: 0, length: attributedString.length)
            )
            meaningLabel.attributedText = attributedString
        }
    }
    
    var meaningLineNumber: Int = 0 {
        didSet {
            meaningLabel.numberOfLines = meaningLineNumber
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WordMeaningView {
    func setupUI() {
        indexLabel.textColor = .gray70
        indexLabel.font = .spoqaBold(size: 14)
        
        meaningLabel.textColor = .gray70
        meaningLabel.font = .spoqaRegular(size: 14)
        meaningLabel.numberOfLines = meaningLineNumber
    }
    
    func setupLayout() {
        [indexLabel, meaningLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            indexLabel.topAnchor.constraint(equalTo: topAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            indexLabel.widthAnchor.constraint(equalToConstant: 13),
            indexLabel.heightAnchor.constraint(equalToConstant: 18),
            
            meaningLabel.topAnchor.constraint(equalTo: indexLabel.topAnchor),
            meaningLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            meaningLabel.leadingAnchor.constraint(equalTo: indexLabel.trailingAnchor, constant: 6),
            meaningLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
