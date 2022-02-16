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
        didSet(newValue) {
            guard let newValue = newValue else { return }
            
            indexLabel.text = "\(newValue)."
        }
    }
    
    var meaning: String? {
        didSet {
            meaningLabel.text = meaning
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
    
    func updateMeaningLineNumber(with number: Int) {
        meaningLabel.numberOfLines = number
    }
}

private extension WordMeaningView {
    func setupUI() {
        indexLabel.textColor = .gray70
        indexLabel.font = .spoqaBold(size: 14)
        
        meaningLabel.textColor = .gray70
        meaningLabel.font = .spoqaRegular(size: 14)
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
            meaningLabel.heightAnchor.constraint(equalTo: indexLabel.heightAnchor),
            meaningLabel.leadingAnchor.constraint(equalTo: indexLabel.trailingAnchor, constant: 6),
            meaningLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
