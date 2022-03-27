//
//  SearchRecentWordsCell.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/19.
//

import UIKit

final class SearchRecentWordsCell: UITableViewCell {
    private lazy var historyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "history")
        return imageView
    }()
    
    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 16)
        label.textColor = .primaryColor
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 12)
        label.textColor = .gray50
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .gray60
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .gray30
        
        addSubview(historyImageView)
        historyImageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        addSubview(wordLabel)
        wordLabel.snp.makeConstraints { make in
            make.leading.equalTo(historyImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(deleteButton.snp.leading).offset(-12)
        }
    }
    
    func setupData(word: String, date: String) {
        wordLabel.text = word
        dateLabel.text = date
    }
}
