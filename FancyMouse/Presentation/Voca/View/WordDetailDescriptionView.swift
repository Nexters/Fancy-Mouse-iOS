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
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 39),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
