//
//  HomeViewController.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/22.
//

import RxCocoa
import RxSwift
import UIKit

final class HomeViewController: UIViewController {
    private let homeViewModel = HomeViewModel(useCase: HomeViewUseCase())
    private let disposeBag = DisposeBag()
    private var words: [Word] = []
    
    private let homeWordCollectionView = HomeWordCollectionView()
    
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
//        setupNavigationBar()
    }
    
    func setupLayout() {
        view.addSubview(homeWordCollectionView)
        
        homeWordCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        homeWordCollectionView.delegate = self
        homeWordCollectionView.dataSource = self
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
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        indexPath.section == 0 ?
        CGSize(width: collectionView.bounds.width - 48, height: 305) :
        CGSize(width: collectionView.bounds.width - 48, height: 131)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        section == 0 ?
        CGSize(width: collectionView.bounds.width - 48, height: 0) :
        CGSize(width: collectionView.bounds.width - 48, height: 30)
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
            return collectionView.dequeueReusableCell(for: indexPath) as HomeProgressView
        }
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as HomeWordCell
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
        ) as HomeSectionHeaderView
        
        headerView.delegate = self
        headerView.bind(hidingStatusObservable: homeViewModel.hidingStatusObservable)
        
        return headerView
    }
    
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

extension HomeViewController: HomeSectionHeaderViewDelegate {
    func didTapShuffleButton(_ homeSectionHeaderView: HomeSectionHeaderView) {
        homeViewModel.shuffleWords()
        DispatchQueue.main.async {
            self.homeWordCollectionView.reloadData()
        }
    }
    
    func didTapHidingSpellingButton(_ homeSectionHeaderView: HomeSectionHeaderView) {
        homeViewModel.changeHidingStatus(with: .word)
    }
    
    func didTapHidingMeaningsButton(_ homeSectionHeaderView: HomeSectionHeaderView) {
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

enum MockData {
    static let words: [Word] = {
        Self.spellings.enumerated().map { index, _ in
            Word(
                id: index,
                folderID: index,
                createdAt: Date(timeIntervalSinceNow: Double(arc4random_uniform(100000))),
                spelling: Self.spellings[index],
                meanings: Self.meaningsList[index],
                memorizationStatus: .inProgress,
                memo: Self.memos[index],
                synonyms: Self.synonymsList[index],
                examples: Self.examplesList[index],
                urlString: ""
            )
        }
    }()
    static let spellings = [
        "purpose",
        "comprehensive",
        "strategy",
        "complication",
        "dim",
        "access",
        "resource",
        "sentimental"
    ]
    static let meaningsList = [
        ["(이루고자 하는·이루어야 할) 목적", "(특정 상황에서 무엇을) 하기 위함, 용도, 의도", "(삶에 의미를 주는) 목적[목적의식]"],
        ["포괄적인", "종합적인", "능력별 구분을 않는"],
        ["전략", "계획"],
        ["(상황을 더 복잡하게 만드는) 문제", "복잡함"],
        ["(빛이) 어둑한", "(장소가) 어둑한", "(형체가) 흐릿한"],
        ["(장소로의) 입장", "접근권, 접촉기회", "(컴퓨터에) 접속하다"],
        ["자원, 재원", "원하는 목적을 이루는 데 도움이 되는) 재료[자산]", "자원[재원]을 제공하다"],
        ["정서(감정)적인", "(지나치게) 감상적인"]
    ]
    static let memos = [
        "꼭 외워야 하는데.. 외우기 쉽지않네..고민된다!",
        "이건 제발 외우자! ㅜㅜ",
        "",
        "",
        "디자인 관련해서 자주 나오는 용어!",
        "",
        "",
        ""
    ]
    static let synonymsList: [[String]] = [
        [],
        ["complete", "full"],
        [],
        [],
        ["vague"],
        [],
        [],
        []
    ]
    static let examplesList: [[String]] = [
        [],
        ["a comprehensive survey of modern music."],
        [],
        [],
        ["This light is too dim to read by."],
        [],
        [],
        []
    ]
}
