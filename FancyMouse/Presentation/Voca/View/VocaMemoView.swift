//
//  VocaMemoView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/25.
//

import UIKit

final class VocaMemoView: UIView {
    private let titleLabel = UILabel()
    private let memoLabel = UILabel()
    private let saveButton = UIButton()
    private let numberOfMemoLabel = UILabel()
    
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
        layer.borderWidth = 1
        layer.borderColor = UIColor.primaryWeek.cgColor
    }
}

private extension VocaMemoView {
    func setupUI() {
        titleLabel.text = "내가 남긴 메모"
        titleLabel.textColor = .gray60
        titleLabel.font = .spoqaMedium(size: 12)
        
        memoLabel.text = "꼭 외워야 하는데.. 외우기 쉽지않네..고민된다!"
        memoLabel.textColor = .primaryDark
        memoLabel.font = .spoqaMedium(size: 16)
        memoLabel.numberOfLines = 0
        
        saveButton.frame = CGRect(x: 0, y: 0, width: 61, height: 28)
        saveButton.layer.backgroundColor = UIColor.gray30.cgColor
        saveButton.layer.cornerRadius = 6
        saveButton.setTitle("수정하기", for: .normal)
        saveButton.setTitleColor(.gray60, for: .normal)
        saveButton.titleLabel?.font = .spoqaMedium(size: 12)
        
        numberOfMemoLabel.text = "46 / 140자"
        numberOfMemoLabel.textColor = .gray50
        numberOfMemoLabel.font = UIFont.systemFont(ofSize: 12)
        numberOfMemoLabel.textAlignment = .right
    }
    
    func setupLayout() {
        [titleLabel, memoLabel, saveButton].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(24)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(28)
            make.width.equalTo(61)
        }
    }
}
