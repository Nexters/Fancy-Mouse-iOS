//
//  WordMoveViewCell.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/17.
//

import UIKit

final class WordMoveViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 16)
        label.textColor = .primaryColor
        return label
    }()
    
    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .primaryColor
        imageView.isHidden = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        wordMove()
    }
    
    private func wordMove() {
        //TODO
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.centerY.leading.equalToSuperview()
        }
        
        addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
        }
    }
    
    func setupLabel(_ title: String) {
        titleLabel.text = title
    }
    
    func setupSelected() {
        titleLabel.font = .spoqaBold(size: 16)
        checkImageView.isHidden = false
    }
}
