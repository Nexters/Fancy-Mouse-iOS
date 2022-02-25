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
        backgroundColor = .white
        
        contourView.backgroundColor = UIColor(
            red: 0.933, green: 0.945, blue: 0.957, alpha: 1
        )
        
        wordCreatedDateLabel.text = "2022-01-20 추가"
        wordCreatedDateLabel.font = .spoqaRegular(size: 12)
        wordCreatedDateLabel.textColor = .gray50
        
        spellingLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func setupLayout() {
        [spellingLabel,
         meaningsStackView,
         statusButton,
         contourView,
         wordCreatedDateLabel
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            spellingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            spellingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            spellingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            meaningsStackView.topAnchor.constraint(equalTo: spellingLabel.bottomAnchor, constant: 20),
            meaningsStackView.leadingAnchor.constraint(equalTo: spellingLabel.leadingAnchor),
            
            statusButton.topAnchor.constraint(equalTo: spellingLabel.topAnchor),
            statusButton.heightAnchor.constraint(equalToConstant: 27),
            statusButton.leadingAnchor.constraint(greaterThanOrEqualTo: spellingLabel.trailingAnchor, constant: 20),
            statusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
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
