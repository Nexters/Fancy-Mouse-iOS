//
//  HomeSectionHeaderView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/03/22.
//

import UIKit

final class HomeSectionHeaderView: UICollectionReusableView {
    private let shuffleButton = UIButton()
    private let hidingSpellingLabel = HomeWordHidingLabel()
    private let ellipseImageView = UIImageView()
    private let hidingMeaningsLabel = HomeWordHidingLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addActionToSuffleButton(
        _ action: UIAction,
        for controlEvent: UIControl.Event = .touchUpInside
    ) {
        shuffleButton.addAction(action, for: controlEvent)
    }
}

private extension HomeSectionHeaderView {
    func setupUI() {
        backgroundColor = .gray30
        hidingSpellingLabel.text = "단어숨김"
        hidingMeaningsLabel.text = "뜻숨김"
        ellipseImageView.image = #imageLiteral(resourceName: "ellipse")
        shuffleButton.setImage(#imageLiteral(resourceName: "shuffle"), for: .normal)
    }
    
    func setupLayout() {
        [hidingSpellingLabel, ellipseImageView, hidingMeaningsLabel, shuffleButton].forEach {
            addSubview($0)
        }
        
        hidingSpellingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(shuffleButton.snp.centerY)
            make.leading.equalToSuperview()
        }
        
        ellipseImageView.snp.makeConstraints { make in
            make.centerY.equalTo(shuffleButton.snp.centerY)
            make.leading.equalTo(hidingSpellingLabel.snp.trailing).offset(8)
        }
        
        hidingMeaningsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(shuffleButton.snp.centerY)
            make.leading.equalTo(ellipseImageView.snp.trailing).offset(8)
        }
        
        shuffleButton.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.bottom.equalToSuperview().offset(3)
            make.trailing.equalToSuperview()
        }
    }
}

final class HomeWordHidingLabel: UILabel {
    init() {
        super.init(frame: .zero)
        
        textColor = .gray50
        font = .spoqaRegular(size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
