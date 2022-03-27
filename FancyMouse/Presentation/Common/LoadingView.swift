//
//  LoadingView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/16.
//

import RxCocoa
import RxSwift
import UIKit

final class LoadingView: UIView {
    private let indicator: UIActivityIndicatorView
    
    private let disposeBag = DisposeBag()
    
    init(indicatorStyle: UIActivityIndicatorView.Style = .medium) {
        indicator = UIActivityIndicatorView(style: indicatorStyle)
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindIndicator(observable: Observable<Bool>) {
        observable
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak indicator] isLoading in
                isLoading ? indicator?.startAnimating() : indicator?.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}
    
private extension LoadingView {
    func setupLayout() {
        addSubview(indicator)
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
