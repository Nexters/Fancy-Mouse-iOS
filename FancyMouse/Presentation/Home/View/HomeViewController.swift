//
//  HomeViewController.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/22.
//

import RxSwift
import RxCocoa
import UIKit

final class HomeViewController: UIViewController {
    private let progressView = HomeProgressView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 305))
    
    private let homeViewModel = HomeViewModel(useCase: HomeViewUseCase())
    private var words: [Word] = []
    
    private lazy var homeWordTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 305, left: 0, bottom: 0, right: -10)
        
        tableView.register(
            HomeWordCell.self,
            forCellReuseIdentifier: "HomeWordCell"
        )
        tableView.register(
            HomeProgressView.self,
            forHeaderFooterViewReuseIdentifier: "HomeProgressView"
        )
        
        tableView.register(
            HomeSectionHeaderView.self,
            forHeaderFooterViewReuseIdentifier: "HomeSectionHeaderView"
        )
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        setupMockData()
        setupTableView()
    }
}

private extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .gray30
        setupNavigationBar()
    }
    
    func setupLayout() {
        view.addSubview(homeWordTableView)
        homeWordTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeWordTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            homeWordTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            homeWordTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            homeWordTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupMockData() {
        let spellings = ["comprehensive", "strategy", "complication", "dim", "access", "resource", "sentimental"]
        let meaningsList = [["포괄적인", "종합적인", "능력별 구분을 않는"], ["전략", "계획"], ["(상황을 더 복잡하게 만드는) 문제", "복잡함"], ["(빛이) 어둑한", "(장소가) 어둑한", "(형체가) 흐릿한"]
                            ,["(장소로의) 입장", "접근권, 접촉기회", "(컴퓨터에) 접속하다"], ["(자원, 재원", "원하는 목적을 이루는 데 도움이 되는) 재료[자산]", "자원[재원]을 제공하다"],
                            ["정서(감정)적인", "(지나치게) 감상적인"]]
        let memos = ["이건 제발 외우자! ㅜㅜ", "", "", "디자인 관련해서 자주 나오는 용어!", "", "", ""]
        let synonymsList: [[String]] = [["complete", "full"],[],[],["vague"],[],[],[]]
        let examplesList: [[String]] = [["a comprehensive survey of modern music."],[],[],["This light is too dim to read by."],[],[],[]]
        
        for idx in (0..<spellings.count) {
            let word = Word(id: idx, folderID: idx, createdAt: Date(timeIntervalSinceNow: Double(arc4random_uniform(100000))),
                            spelling: spellings[idx], meanings: meaningsList[idx],
                            memorizationStatus: .inProgress, memo: memos[idx], synonyms: synonymsList[idx], examples: examplesList[idx], urlString: "")
            words.append(word)
        }
    }
    
    func setupTableView() {
        homeWordTableView.delegate = self
        homeWordTableView.dataSource = self
        
        homeWordTableView.tableHeaderView = progressView
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "HomeSectionHeaderView"
        ) as? HomeSectionHeaderView
        else { return nil }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "HomeWordCell",
                for: indexPath
            ) as? HomeWordCell
        else { return UITableViewCell() }
        
        let cellViewModel = HomeWordCellViewModel(
            useCase: HomeWordUseCase(),
            word: words[indexPath.row],
            hidingStatusRelay: BehaviorRelay<HomeViewModel.HidingStatus>(value: .none)
        )
        cell.configure(viewModel: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        131 + 12
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
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
    func shuffleWords() -> Observable<[Word]> {
        return PublishSubject<[Word]>()
    }
    
    func loadWords() -> Observable<[Word]> {
        return PublishSubject<[Word]>()
    }
}

final class HomeSectionHeaderView: UITableViewHeaderFooterView {
    private var hiddingLabel: UILabel {
        let hiddingLabel = UILabel()
        hiddingLabel.textColor = .gray50
        hiddingLabel.font = .spoqaRegular(size: 14)
        
        return hiddingLabel
    }
    
    private lazy var sectionHeaderView: UIView = {
        let sectionHeaderView = UIView()
        
        let hidingSpellingLabel = hiddingLabel
        let ellipseImageView = UIImageView()
        let hidingMeaningsLabel = hiddingLabel
        let suffleButton = UIButton()
        
        hidingSpellingLabel.text = "단어숨김"
        hidingMeaningsLabel.text = "뜻숨김"
        ellipseImageView.image = #imageLiteral(resourceName: "ellipse")
        suffleButton.setImage(#imageLiteral(resourceName: "suffle"), for: .normal)
        
        [hidingSpellingLabel, ellipseImageView, hidingMeaningsLabel, suffleButton].forEach {
            sectionHeaderView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            hidingSpellingLabel.centerYAnchor.constraint(equalTo: suffleButton.centerYAnchor),
            hidingSpellingLabel.leadingAnchor.constraint(equalTo: sectionHeaderView.leadingAnchor),
            
            ellipseImageView.centerYAnchor.constraint(equalTo: suffleButton.centerYAnchor),
            ellipseImageView.leadingAnchor.constraint(equalTo: hidingSpellingLabel.trailingAnchor, constant: 8),
            
            hidingMeaningsLabel.centerYAnchor.constraint(equalTo: suffleButton.centerYAnchor),
            hidingMeaningsLabel.leadingAnchor.constraint(equalTo: ellipseImageView.trailingAnchor, constant: 8),
            
            suffleButton.topAnchor.constraint(equalTo: sectionHeaderView.topAnchor),
            suffleButton.bottomAnchor.constraint(equalTo: sectionHeaderView.bottomAnchor),
            suffleButton.trailingAnchor.constraint(equalTo: sectionHeaderView.trailingAnchor)
        ])
        
        return sectionHeaderView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(sectionHeaderView)
        sectionHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sectionHeaderView.topAnchor.constraint(equalTo: topAnchor),
            sectionHeaderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sectionHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
