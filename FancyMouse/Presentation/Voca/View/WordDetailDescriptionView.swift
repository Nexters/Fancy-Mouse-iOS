//
//  WordDetailDescriptionView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/24.
//

import UIKit

final class WordDetailDescriptionView: UIView {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var descriptionString: String? {
        didSet {
            let attributedString = NSMutableAttributedString(string: descriptionString ?? "")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            attributedString.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: NSRange(location: 0, length: attributedString.length)
            )
            descriptionLabel.attributedText = attributedString
        }
    }
    
    var titleLabelColor: UIColor = .gray70 {
        didSet {
            titleLabel.textColor = titleLabelColor
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

private extension WordDetailDescriptionView {
    func setupUI() {
        titleLabel.textColor = titleLabelColor
        titleLabel.font = .spoqaBold(size: 14)
        
        descriptionLabel.textColor = .gray60
        descriptionLabel.font = .spoqaRegular(size: 14)
        descriptionLabel.numberOfLines = 0
    }
    
    func setupLayout() {
        [titleLabel, descriptionLabel].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(39)
            make.height.equalTo(18)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.bottom.trailing.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
        }
    }
}
