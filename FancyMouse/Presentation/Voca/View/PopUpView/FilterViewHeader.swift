//
//  FilterViewHeader.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/10.
//

import UIKit

final class FilterViewHeader: UICollectionReusableView {
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .spoqaMedium(size: 14)
        label.textColor = .gray70
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = .white
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.leading.equalToSuperview()
        }
    }
}
