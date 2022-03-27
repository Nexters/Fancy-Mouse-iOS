//
//  TogetherSavedSentenceView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/25.
//

import UIKit

final class TogetherSavedSentenceView: UIView {
    private let titleLabel = UILabel()
    private let sentenceLabel = UILabel()
    
    var sentence: String = "" {
        didSet {
            sentenceLabel.text = sentence
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 20
    }
}

private extension TogetherSavedSentenceView {
    func setupUI() {
        backgroundColor = .gray30
        
        titleLabel.text = "함께 저장한 문장"
        titleLabel.textColor = .gray60
        titleLabel.font = .spoqaMedium(size: 12)
        
        sentenceLabel.textColor = .primaryDark
        sentenceLabel.font = .spoqaRegular(size: 16)
        sentenceLabel.numberOfLines = 3
    }
    
    func setupLayout() {
        [titleLabel, sentenceLabel].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(24)
        }
        
        sentenceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
