//
//  FilterViewCell.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/08.
//

import UIKit

final class FilterViewCell: UICollectionViewCell {
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 14)
        label.textColor = .primary
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 1.5
                layer.borderColor = UIColor.primary?.cgColor
                title.font = .spoqaMedium(size: 14)
            } else {
                layer.borderWidth = 1
                layer.borderColor = UIColor.primaryWeek?.cgColor
                title.font = .spoqaRegular(size: 14)
            }
        }
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.primaryWeek?.cgColor
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
