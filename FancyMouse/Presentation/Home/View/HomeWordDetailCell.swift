//
//  HomeWordDetailCell.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/25.
//

import RxCocoa
import RxSwift
import UIKit

final class HomeWordDetailCell: UITableViewCell {
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    private let view = UIView()
    private let spellingLabel = WordSpellingLabel()
    private let meaningsStackView = WordMeaningsStackView()
    private let statusButton = WordMemorizationBadgeButton()
    private let contourView = UIView()
    private let wordCreatedDateLabel = UILabel()
    
    private var viewModel: HomeWordCellViewModel?
    private var disposeBag = DisposeBag()
    
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
    
    func configure(viewModel: HomeWordCellViewModel) {
        self.viewModel = viewModel
        
        setupUI()
        setupLayout()
        
        bindViewModel()
    }
}

private extension HomeWordDetailCell {
    func setupUI() {
        backgroundColor = .gray30
        view.backgroundColor = .white
        
        contourView.backgroundColor = UIColor(
            red: 0.933, green: 0.945, blue: 0.957, alpha: 1
        )
        
        wordCreatedDateLabel.text = "2022-01-20 추가"
        wordCreatedDateLabel.font = .spoqaRegular(size: 12)
        wordCreatedDateLabel.textColor = .gray50
        
        spellingLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        statusButton.titleLabel?.font = .spoqaBold(size: 12)
    }
    
    func setupLayout() {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        [spellingLabel, statusButton,
         meaningsStackView,
         contourView,
         wordCreatedDateLabel
        ].forEach {
            view.addSubview($0)
        }
        
        view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview()
        }
        
        spellingLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(24)
        }
        
        meaningsStackView.snp.makeConstraints { make in
            make.top.equalTo(spellingLabel.snp.bottom).offset(20)
            make.bottom.equalTo(view.snp.bottom).inset(24)
            make.leading.equalTo(spellingLabel.snp.leading)
            make.trailing.equalTo(view.snp.trailing).inset(24)
        }
        
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(spellingLabel.snp.top)
            make.leading.greaterThanOrEqualTo(spellingLabel.snp.trailing).offset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
            make.width.equalTo(54)
            make.height.equalTo(27)
        }
        
        contourView.snp.makeConstraints { make in
            make.top.equalTo(meaningsStackView.snp.top).offset(20)
            make.leading.trailing.equalTo(spellingLabel)
        }
        
        wordCreatedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(contourView.snp.bottom).offset(12)
            make.leading.equalTo(spellingLabel.snp.leading)
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
    }
}
