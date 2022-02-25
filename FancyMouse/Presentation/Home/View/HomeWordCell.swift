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
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            spellingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            spellingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            meaningsStackView.topAnchor.constraint(equalTo: spellingLabel.bottomAnchor, constant: 20),
            meaningsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            meaningsStackView.leadingAnchor.constraint(equalTo: spellingLabel.leadingAnchor),
            meaningsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            statusButton.topAnchor.constraint(equalTo: spellingLabel.topAnchor),
            statusButton.heightAnchor.constraint(equalToConstant: 27),
            statusButton.widthAnchor.constraint(equalToConstant: 54),
            statusButton.leadingAnchor.constraint(greaterThanOrEqualTo: spellingLabel.trailingAnchor, constant: 20),
            statusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
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
