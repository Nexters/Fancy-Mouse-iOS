//
//  WordTestCell.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/01.
//

import RxCocoa
import RxSwift
import UIKit

final class WordTestCell: UICollectionViewCell {
    private let spellingLabel = WordSpellingLabel()
    private let meaningsStackView = WordMeaningsStackView()
    private let statusButton = WordMemorizationBadgeButton()
    
    private var viewModel: HomeWordCellViewModel?
    private var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 20
    }
    
    func configure(viewModel: HomeWordCellViewModel) {
        self.viewModel = viewModel
        
        setupUI()
        setupLayout()
        
        bindViewModel()
        bindUI(withViewModel: viewModel)
    }
}

private extension WordTestCell {
    func setupUI() {
        backgroundColor = .white
        
        spellingLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let statusButtonAction = UIAction { _ in
            let isIncomplete = self.statusButton.titleLabel?.text == "미암기"
            isIncomplete ? self.statusButton.setupInProgress() : self.statusButton.setupIncomplete()
        }
        
        statusButton.addAction(statusButtonAction, for: .touchUpInside)
        statusButton.titleLabel?.font = .spoqaBold(size: 12)
    }
    
    func setupLayout() {
        [spellingLabel, meaningsStackView, statusButton].forEach {
            addSubview($0)
        }
        
        spellingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        meaningsStackView.snp.makeConstraints { make in
            make.top.equalTo(spellingLabel.snp.bottom).offset(20)
            make.leading.equalTo(spellingLabel.snp.leading)
            make.bottom.trailing.equalToSuperview().inset(24)
        }
        
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(spellingLabel.snp.top)
            make.leading.greaterThanOrEqualTo(spellingLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(54)
            make.height.equalTo(27)
        }
    }
    
    func bindViewModel() {
        viewModel?.wordObservable
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] in
                self?.updateWord($0)
            })
            .disposed(by: disposeBag)
        
        viewModel?.hidingStatusObservable
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] status in
                switch status {
                case .none:
                    self?.spellingLabel.show()
                    self?.meaningsStackView.show()
                case .meaning:
                    self?.spellingLabel.show()
                    self?.meaningsStackView.hide()
                case .word:
                    self?.spellingLabel.hide()
                    self?.meaningsStackView.show()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func bindUI(withViewModel viewModel: HomeWordCellViewModel) {
        statusButton.rx.tap
            .subscribe(onNext: {
                viewModel.toggleMemorizationStatus()
            })
            .disposed(by: disposeBag)
        
        statusButton.bindLoadingView(with: viewModel.loadingObservable)
    }
    
    func updateWord(_ word: Word) {
        spellingLabel.text = word.spelling
        var meanings = [String]()
        word.meanings.enumerated().forEach { index, meaning in
            if index < 2 {
                meanings.append(meaning)
            }
        }
        
        meaningsStackView.addSubMeaningViews(with: meanings)
        
        switch word.memorizationStatus {
        case .incomplete: statusButton.setupIncomplete()
        case .inProgress: statusButton.setupInProgress()
        default: break
        }
    }
}
