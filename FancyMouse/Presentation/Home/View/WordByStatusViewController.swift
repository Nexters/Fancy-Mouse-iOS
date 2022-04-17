//
//  WordByStatusViewController.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/04/17.
//

import RxCocoa
import RxSwift
import UIKit

final class WordByStatusViewController: UIViewController {
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(
            section: CollectionViewComponents.makeWordDetailSection()
        )
    )
    private var ellipsisView: EllipsisView?
    
    private let homeViewModel = HomeViewModel(useCase: HomeViewUseCase())
    private let disposeBag = DisposeBag()
    private var words: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        setupCollectionView()
        bindViewModel()
        homeViewModel.loadWords()
    }
}

extension WordByStatusViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let viewController = VocaDetailViewController()
        viewController.configure(wordID: indexPath.row)
        show(viewController, sender: self)
    }
}

extension WordByStatusViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        words.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as WordCell
        let cellViewModel = HomeWordCellViewModel(
            useCase: HomeWordUseCase(),
            word: words[indexPath.row],
            hidingStatusObservable: homeViewModel.hidingStatusObservable
        )
        cell.configure(viewModel: cellViewModel)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(
            for: indexPath
        ) as WordSectionHeaderView
        
        headerView.totalCount = words.count
//        headerView.delegate = self
        
        return headerView
    }
}

extension WordByStatusViewController: WordCellDelegate {
    func didTapMoreButton(_ button: UIButton) {
        ellipsisView?.removeFromSuperview()
        ellipsisView = EllipsisView()
        
        ellipsisView?.addComponent(title: "이동하기", imageName: "edit", action: UIAction { _ in
            self.ellipsisView?.removeFromSuperview()
        })
        ellipsisView?.addComponent(title: "삭제하기", imageName: "delete", action: UIAction { _ in
            self.ellipsisView?.removeFromSuperview()
        })
        
        view.addSubview(ellipsisView ?? UIView())
        self.ellipsisView?.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(100)
            make.top.equalTo(button.snp.bottom).offset(8)
            make.trailing.equalTo(button.snp.trailing).offset(18)
        }
    }
}

private extension WordByStatusViewController {
    func setupUI() {
        view.backgroundColor = .gray30
        collectionView.backgroundColor = .gray30
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerCell(ofType: WordCell.self)
        collectionView.registerSupplementaryView(ofType: WordSectionHeaderView.self)
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
