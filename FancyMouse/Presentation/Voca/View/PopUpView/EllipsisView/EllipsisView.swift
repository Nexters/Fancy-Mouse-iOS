//
//  EllipsisView.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/03.
//

import UIKit

final class EllipsisView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .gray70
        layer.cornerRadius = 14
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(16)
        }
    }
    
    func addComponent(title: String, imageName: String, action: UIAction) {
        let button: UIButton = {
            let button = UIButton()
            let image = UIImage(named: imageName)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .spoqaMedium(size: 14)
            button.setImage(image, for: .normal)
            button.semanticContentAttribute = .forceLeftToRight
            button.addAction(action, for: .touchUpInside)
            return button
        }()
        stackView.addArrangedSubview(button)
    }
}
