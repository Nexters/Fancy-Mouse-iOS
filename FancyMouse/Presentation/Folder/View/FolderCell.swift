//
//  FolderCell.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import UIKit

class FolderCell: UICollectionViewCell {
    lazy var folderImageView = UIImageView()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more"), for: .normal)
        return button
    }()
    
    lazy var folderNameLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaBold(size: 16)
        label.textColor = .primaryDark
        return label
    }()
    
    lazy var wordCountLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaBold(size: 14)
        label.textColor = .gray60
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(folderNameLabel)
        addSubview(wordCountLabel)
        addSubview(folderImageView)
        addSubview(moreButton)
    }
    
    private func setupLayout() {
        folderImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        folderNameLabel.snp.makeConstraints { make in
            make.top.equalTo(folderImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(54)
        }
        
        wordCountLabel.snp.makeConstraints { make in
            make.top.equalTo(folderNameLabel.snp.bottom).offset(37)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setupData(title: String, count: Int, color: FolderColor) {
        var imageString = ""
        
        switch color {
        case .folder00 ?? .folder00: imageString = "folder00"
        case .folder01 ?? .folder01: imageString = "folder01"
        case .folder02 ?? .folder02: imageString = "folder02"
        case .folder03 ?? .folder03: imageString = "folder03"
        case .folder04 ?? .folder04: imageString = "folder04"
        case .folder05 ?? .folder05: imageString = "folder05"
        case .folder06 ?? .folder06: imageString = "folder06"
        case .folder07 ?? .folder07: imageString = "folder07"
        case .folder08 ?? .folder08: imageString = "folder08"
        case .folder09 ?? .folder09: imageString = "folder09"
        case .folder10 ?? .folder10: imageString = "folder10"
        case .folder11 ?? .folder11: imageString = "folder11"
        default: imageString = "folder00"
        }
        
        folderImageView.image = UIImage(named: imageString)
        folderNameLabel.text = title
        wordCountLabel.text = "\(count)"
    }
}
