//
//  HomeWordCell.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/01.
//

import RxCocoa
import RxSwift
import UIKit

// TODO: Reusable 기본 identifier 같은거 공통으로 사용할 수 있는 프로토콜 만들기
final class HomeWordCell: UITableViewCell {
    static var identifier: String {
        return String(describing: Self.self)
    }
    private let view = UIView()
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
        
        view.layer.cornerRadius = 20
    }
    
    func configure(viewModel: HomeWordCellViewModel) {
        self.viewModel = viewModel
        
        setupUI()
        setupLayout()
        
        bindViewModel()
        bindUI(withViewModel: viewModel)
    }
}

private extension HomeWordCell {
    func setupUI() {
        backgroundColor = .gray30
        view.backgroundColor = .white
        
        spellingLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let action = UIAction { _ in
            if self.statusButton.titleLabel?.text == "미암기" {
                self.statusButton.setupInProgress()
            } else {
                self.statusButton.setupIncomplete()
            }
        }
        
        statusButton.addAction(action, for: .touchUpInside)
        statusButton.titleLabel?.font = .spoqaBold(size: 12)
    }
    
    func setupLayout() {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        [spellingLabel, meaningsStackView, statusButton].forEach {
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
    }
    
    func bindViewModel() {
        viewModel?.wordObservable
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] in
                self?.updateWord($0)
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
