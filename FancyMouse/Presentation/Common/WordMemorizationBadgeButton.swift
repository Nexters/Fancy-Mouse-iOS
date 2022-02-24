//
//  WordMemorizationBadgeButton.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/16.
//

import RxCocoa
import RxSwift
import UIKit

final class WordMemorizationBadgeButton: UIButton {
    private let loadingView = LoadingView()
    
    init() {
        super.init(frame: .zero)
        
        titleEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = circularCornerRadius
    }
    
    func bindLoadingView(with observable: Observable<Bool>) {
        loadingView.bindIndicator(observable: observable)
    }
    
    func setupIncomplete() {
        backgroundColor = .gray30
        setTitleColor(.gray50, for: .normal)
        setTitle("미암기", for: .normal)
    }
    
    func setupInProgress() {
        backgroundColor = .primaryColor
        setTitleColor(.white, for: .normal)
        setTitle("암기중", for: .normal)
    }
}
