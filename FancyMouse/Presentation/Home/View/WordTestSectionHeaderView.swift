//
//  WordTestSectionHeaderView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/03/22.
//

import RxSwift
import UIKit

protocol WordTestSectionHeaderViewDelegate: AnyObject {
    func didTapShuffleButton(_ headerView: WordTestSectionHeaderView)
    func didTapHidingSpellingButton(_ headerView: WordTestSectionHeaderView)
    func didTapHidingMeaningsButton(_ headerView: WordTestSectionHeaderView)
}

final class EmptySectionHeaderView: UICollectionReusableView { }

final class WordTestSectionHeaderView: UICollectionReusableView {
    private let shuffleButton = UIButton()
    private let hidingSpellingButton = HomeWordHidingButton()
    private let ellipseImageView = UIImageView()
    // TODO: 영어천재 sueaty가 meaning 대신 definition을 쓰라고 했음
    private let hidingMeaningsButton = HomeWordHidingButton()
    private let disposeBag = DisposeBag()
    
    weak var delegate: WordTestSectionHeaderViewDelegate?
    var hidingStatusObservable: Observable<HomeViewModel.HidingStatus>?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(hidingStatusObservable: Observable<HomeViewModel.HidingStatus>) {
        self.hidingStatusObservable = hidingStatusObservable
        
        self.hidingStatusObservable?
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] status in
                switch status {
                case .none:
                    self?.hidingSpellingButton.unfocused()
                    self?.hidingMeaningsButton.unfocused()
                case .word:
                    self?.hidingSpellingButton.focused()
                    self?.hidingMeaningsButton.unfocused()
                case .meaning:
                    self?.hidingSpellingButton.unfocused()
                    self?.hidingMeaningsButton.focused()
                }
            })
            .disposed(by: disposeBag)
    }
}

private extension WordTestSectionHeaderView {
    func setupUI() {
        backgroundColor = .gray30
        hidingSpellingButton.setTitle("단어숨김", for: .normal)
        hidingMeaningsButton.setTitle("뜻숨김", for: .normal)
        ellipseImageView.image = #imageLiteral(resourceName: "ellipse")
        shuffleButton.setImage(#imageLiteral(resourceName: "shuffle"), for: .normal)
    }
    
    func setupAction() {
        let hidingSpellingButtonAction = UIAction { _ in
            self.delegate?.didTapHidingSpellingButton(self)
        }
        hidingSpellingButton.addAction(hidingSpellingButtonAction, for: .touchUpInside)
        
        let hidingMeaningsButtonAction = UIAction { _ in
            self.delegate?.didTapHidingMeaningsButton(self)
        }
        hidingMeaningsButton.addAction(hidingMeaningsButtonAction, for: .touchUpInside)
        
        let shuffleButtonAction = UIAction { _ in
            self.delegate?.didTapShuffleButton(self)
        }
        shuffleButton.addAction(shuffleButtonAction, for: .touchUpInside)
    }
    
    func setupLayout() {
        [hidingSpellingButton, ellipseImageView, hidingMeaningsButton, shuffleButton].forEach {
            addSubview($0)
        }
        
        hidingSpellingButton.snp.makeConstraints { make in
            make.centerY.equalTo(shuffleButton.snp.centerY)
            make.leading.equalToSuperview()
        }
        
        ellipseImageView.snp.makeConstraints { make in
            make.centerY.equalTo(shuffleButton.snp.centerY)
            make.leading.equalTo(hidingSpellingButton.snp.trailing).offset(8)
        }
        
        hidingMeaningsButton.snp.makeConstraints { make in
            make.centerY.equalTo(shuffleButton.snp.centerY)
            make.leading.equalTo(ellipseImageView.snp.trailing).offset(8)
        }
        
        shuffleButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(3)
            make.trailing.equalToSuperview()
        }
    }
}

final class HomeWordHidingButton: UIButton {
    init() {
        super.init(frame: .zero)
        
        setTitleColor(.gray50, for: .normal)
        titleLabel?.font = .spoqaRegular(size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeWordHidingButton {
    func focused() {
        setTitleColor(.gray70, for: .normal)
        titleLabel?.font = .spoqaBold(size: 14)
    }
    
    func unfocused() {
        setTitleColor(.gray50, for: .normal)
        titleLabel?.font = .spoqaRegular(size: 14)
    }
}
