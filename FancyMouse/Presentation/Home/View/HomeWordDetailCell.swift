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
        
        [spellingLabel,
         meaningsStackView,
         statusButton,
         contourView,
         wordCreatedDateLabel
        ].forEach {
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
            statusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            contourView.topAnchor.constraint(equalTo: meaningsStackView.bottomAnchor, constant: 20),
            contourView.leadingAnchor.constraint(equalTo: spellingLabel.leadingAnchor),
            contourView.trailingAnchor.constraint(equalTo: spellingLabel.trailingAnchor),
            
            wordCreatedDateLabel.topAnchor.constraint(equalTo: contourView.bottomAnchor, constant: 12),
            wordCreatedDateLabel.leadingAnchor.constraint(equalTo: spellingLabel.leadingAnchor)
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
    
    func updateWord(_ word: Word) {
        spellingLabel.text = word.spelling
    }
}
