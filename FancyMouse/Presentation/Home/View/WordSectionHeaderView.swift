//
//  WordSectionHeaderView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/04/17.
//

import RxSwift
import UIKit

final class WordSectionHeaderView: UICollectionReusableView {
    private let totalLabel = UILabel()
    private let numberLabel = UILabel()
    private let countLabel = UILabel()
    private let filterButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var totalCount: Int = 0 {
        didSet {
            numberLabel.text = "\(totalCount)"
        }
    }
}

private extension WordSectionHeaderView {
    func setupUI() {
        totalLabel.text = "총"
        numberLabel.text = "\(totalCount)"
        countLabel.text = "개"
        
        [totalLabel, countLabel].forEach {
            $0.font = .spoqaRegular(size: 14)
            $0.textColor = .gray50
        }
        
        numberLabel.font = .spoqaBold(size: 14)
        numberLabel.textColor = .gray70
        
        filterButton.setImage(#imageLiteral(resourceName: "btn_filter"), for: .normal)
    }
    
    func setupLayout() {
        [totalLabel, numberLabel, countLabel, filterButton].forEach {
            addSubview($0)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.centerY.equalTo(filterButton.snp.centerY)
            make.leading.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(filterButton.snp.centerY)
            make.leading.equalTo(totalLabel.snp.trailing).offset(3)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(filterButton.snp.centerY)
            make.leading.equalTo(numberLabel.snp.trailing)
        }
        
        filterButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
