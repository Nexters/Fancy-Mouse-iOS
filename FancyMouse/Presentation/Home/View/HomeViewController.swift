//
//  HomeViewController.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/22.
//

import RxCocoa
import RxSwift
import UIKit

final class HomeViewController: BaseViewController {
    private let homeViewModel = HomeViewModel(useCase: HomeViewUseCase())
    private let disposeBag = DisposeBag()
    private var words: [Word] = []
    
    private let collectionView = WordTestCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()

        setupCollectionView()
        bindViewModel()
        homeViewModel.loadWords()
    }
}

private extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .gray30
        setupNavigationTitleImage()
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func bindViewModel() {
        homeViewModel.wordsObservable
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] in
                self?.words = $0
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard indexPath.section > 0 else { return }
        
        let viewController = VocaDetailViewController()
        viewController.configure(wordID: indexPath.row)
        show(viewController, sender: self)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0: return 1
        case 1: return words.count
        default: return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath) as WordProgressCell
            cell.delegate = self
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as WordTestCell
        let cellViewModel = HomeWordCellViewModel(
            useCase: HomeWordUseCase(),
            word: words[indexPath.row],
            hidingStatusObservable: homeViewModel.hidingStatusObservable
        )
        cell.configure(viewModel: cellViewModel)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if indexPath.section == 0 {
            return collectionView.dequeueReusableSupplementaryView(
                for: indexPath
            ) as EmptySectionHeaderView
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            for: indexPath
        ) as WordTestSectionHeaderView
        
        headerView.delegate = self
        headerView.bind(hidingStatusObservable: homeViewModel.hidingStatusObservable)
        
        return headerView
    }
}

extension HomeViewController: WordProgressCellDelegate {
    func didTapEntryButton(_ homeProgressCell: WordProgressCell) {
        let viewController = WordByStatusViewController()
        show(viewController, sender: self)
    }
}

extension HomeViewController: WordTestSectionHeaderViewDelegate {
    func didTapShuffleButton(_ homeSectionHeaderView: WordTestSectionHeaderView) {
        homeViewModel.shuffleWords()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didTapHidingSpellingButton(_ homeSectionHeaderView: WordTestSectionHeaderView) {
        homeViewModel.changeHidingStatus(with: .word)
    }
    
    func didTapHidingMeaningsButton(_ homeSectionHeaderView: WordTestSectionHeaderView) {
        homeViewModel.changeHidingStatus(with: .meaning)
    }
}

struct HomeWordUseCase: HomeWordUseCaseProtocol {
    func changeMemorizationStatus(
        to newStatus: Word.MemorizationStatus,
        of wordID: WordID
    ) -> Observable<Word> {
        return PublishSubject<Word>()
    }
}

struct HomeViewUseCase: HomeUseCaseProtocol {
    func loadWords() -> Observable<[Word]> {
        return BehaviorSubject<[Word]>(value: MockData.words)
    }
}
