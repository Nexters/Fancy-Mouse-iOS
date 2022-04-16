//
//  FolderCell.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import UIKit

final class FolderCell: UICollectionViewCell {
    private lazy var folderImageView = UIImageView()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more"), for: .normal)
        return button
    }()
    
    private lazy var folderNameLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaBold(size: 16)
        label.textColor = .primaryDark
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var wordCountLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaBold(size: 14)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moreButton.isHidden = false
    }
}

private extension FolderCell {
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 20
        
        addSubview(folderNameLabel)
        addSubview(wordCountLabel)
        addSubview(folderImageView)
        addSubview(moreButton)
        
        setupLayout()
    }
    
    func setupLayout() {
        layer.applyShadow()
        
        folderImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        folderNameLabel.snp.makeConstraints { make in
            make.top.equalTo(folderImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        wordCountLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}

extension FolderCell {
    func setupData(title: String, count: Int, colorString: String) {
        folderImageView.image = UIImage(named: colorString)
        folderNameLabel.text = title
        wordCountLabel.text = "\(count)"
    }
}
