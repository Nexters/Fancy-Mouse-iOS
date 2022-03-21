//
//  FolderAddCell.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/25.
//

import UIKit

final class FolderAddCell: UICollectionViewCell {
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "plus")
        return imageView
    }()
    
    private lazy var plusLabel: UILabel = {
        let label = UILabel()
        label.text = "폴더 추가하기"
        label.font = .spoqaMedium(size: 14)
        label.textColor = .gray60
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension FolderAddCell {
    func setupView() {
        addSubview(plusImageView)
        addSubview(plusLabel)
        setupLayout()
    }
    
    func setupLayout() {
        backgroundColor = .gray30
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.applyShadow(alpha: 0.4, blur: 20)
        
        plusImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.centerX.equalToSuperview()
        }
        plusLabel.snp.makeConstraints { make in
            make.top.equalTo(plusImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}
