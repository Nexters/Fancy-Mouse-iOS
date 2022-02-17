//
//  EllipsisView.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/03.
//

import UIKit

enum EllipsisMode {
    case folder
    case word
}

final class EllipsisView: UIView {
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .spoqaMedium(size: 14)
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .spoqaMedium(size: 14)
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        return button
    }()
    
    private lazy var moveButton: UIButton = {
        let button = UIButton()
        button.setTitle("이동하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .spoqaMedium(size: 14)
        button.setImage(UIImage(named: "move"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        return button
    }()
    
    init(frame: CGRect, mode: EllipsisMode) {
        super.init(frame: frame)
        setup(mode)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup(_ mode: EllipsisMode) {
        backgroundColor = .gray70
        layer.cornerRadius = 14
        
        let button = mode == .folder ? moveButton : editButton
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.bottom.equalToSuperview().offset(-57)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(57)
            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}

