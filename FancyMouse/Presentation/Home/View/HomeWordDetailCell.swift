//
//  HomeWordDetailCell.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/25.
//

import RxCocoa
import RxSwift
import UIKit

protocol HomeWordDetailCellDelegate: AnyObject {
    func didTapMoreButton(_ moreButton: UIButton)
}

final class HomeWordDetailCell: UICollectionViewCell {
    private let spellingLabel = WordSpellingLabel()
    private let meaningsStackView = WordMeaningsStackView()
    private let statusButton = WordMemorizationBadgeButton()
    private let contourView = UIView()
    private let wordCreatedDateLabel = UILabel()
    private let moreButton = UIButton()
    
    private var viewModel: HomeWordCellViewModel?
    private var disposeBag = DisposeBag()
    
    weak var delegate: HomeWordDetailCellDelegate?
    
    var isStatusButtonHidden = false {
        didSet {
            statusButton.isHidden = isStatusButtonHidden
        }
    }
    
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
    }
}

private extension HomeWordDetailCell {
    func setupUI() {
        backgroundColor = .white
        
        contourView.backgroundColor = .gray30
        
        wordCreatedDateLabel.text = "2022-01-20 추가"
        wordCreatedDateLabel.font = .spoqaRegular(size: 12)
        wordCreatedDateLabel.textColor = .gray50
        
        spellingLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        statusButton.titleLabel?.font = .spoqaBold(size: 12)
        
        moreButton.setImage(UIImage(named: "more"), for: .normal)
        let moreButtonAction = UIAction { _ in
            self.delegate?.didTapMoreButton(self.moreButton)
        }
        moreButton.addAction(moreButtonAction, for: .touchUpInside)
    }
    
    func setupLayout() {
        [spellingLabel, statusButton,
         meaningsStackView,
         contourView,
         wordCreatedDateLabel,
         moreButton
        ].forEach {
            addSubview($0)
        }
        
        spellingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        meaningsStackView.snp.makeConstraints { make in
            make.top.equalTo(spellingLabel.snp.bottom).offset(20)
            make.leading.equalTo(spellingLabel.snp.leading)
            make.trailing.equalToSuperview().inset(24)
        }
        
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(spellingLabel.snp.top)
            make.leading.greaterThanOrEqualTo(spellingLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(54)
            make.height.equalTo(27)
        }
        
        contourView.snp.makeConstraints { make in
            make.top.equalTo(meaningsStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        wordCreatedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(contourView.snp.bottom).offset(12)
            make.leading.equalTo(spellingLabel.snp.leading)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(wordCreatedDateLabel.snp.centerY)
            make.bottom.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
    func bindViewModel() {
        viewModel?.wordObservable
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] in
                self?.updateWord($0)
            })
            .disposed(by: disposeBag)
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
