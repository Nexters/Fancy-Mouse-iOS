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
        }
        
        indexLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(13)
            make.height.equalTo(18)
        }
        
        meaningLabel.snp.makeConstraints { make in
            make.top.equalTo(indexLabel.snp.top)
            make.bottom.equalToSuperview()
            make.leading.equalTo(indexLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview()
        }
    }
}
