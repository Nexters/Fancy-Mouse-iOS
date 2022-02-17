//
//  FilterViewCell.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/08.
//

import UIKit

final class FilterViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 14)
        label.textColor = .primaryColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            setupSelected(isSelected)
        }
    }
    
    private func setupSelected(_ selected: Bool) {
        if selected {
            layer.borderWidth = 1.5
            layer.borderColor = UIColor.primaryColor?.cgColor
            titleLabel.font = .spoqaMedium(size: 14)
        } else {
            layer.borderWidth = 1
            layer.borderColor = UIColor.primaryWeek?.cgColor
            titleLabel.font = .spoqaRegular(size: 14)
        }
    }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.primaryWeek?.cgColor
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setupLabel(_ title: String) {
        titleLabel.text = title
    }
}
