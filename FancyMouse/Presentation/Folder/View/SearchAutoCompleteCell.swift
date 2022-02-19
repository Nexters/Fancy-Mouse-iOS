//
//  SearchAutoCompleteCell.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/19.
//

import RxSwift
import UIKit

final class SearchAutoCompleteCell: UITableViewCell {
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        return imageView
    }()
    
    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 16)
        label.textColor = .gray50
        return label
    }()
    
    private lazy var meaningLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 16)
        label.textColor = .gray70
        return label
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
        
        addSubview(searchImageView)
        searchImageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        addSubview(wordLabel)
        wordLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        addSubview(meaningLabel)
        meaningLabel.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
        }
    }
    
    func setupData(word: String, meaning: String, inputText: String) {
        let attributedStr = NSMutableAttributedString(string: word)
        
        attributedStr.addAttribute(
            .foregroundColor,
            value: UIColor.primaryColor as Any,
            range: (word as NSString).range(of: inputText, options: .caseInsensitive)
        )
        wordLabel.attributedText = attributedStr
        meaningLabel.text = meaning
    }
}
