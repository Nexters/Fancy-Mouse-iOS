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
    private let progressView = HomeProgressView(
        frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 305)
    )
    
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
        
        homeWordTableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func setupTableView() {
        homeWordTableView.delegate = self
        homeWordTableView.dataSource = self
        
        homeWordTableView.tableHeaderView = progressView
    }
    
    func setupMockData() {
        for index in (0..<Self.spellings.count) {
            let word = Word(
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
            words.append(word)
        }
    }
}

private extension HomeViewController {
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
        ["포괄적인", "종합적인", "능력별 구분을 않는"], ["전략", "계획"], ["(상황을 더 복잡하게 만드는) 문제", "복잡함"],
        ["(빛이) 어둑한", "(장소가) 어둑한", "(형체가) 흐릿한"],
        ["(장소로의) 입장", "접근권, 접촉기회", "(컴퓨터에) 접속하다"],
        ["(자원, 재원", "원하는 목적을 이루는 데 도움이 되는) 재료[자산]", "자원[재원]을 제공하다"],
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "HomeSectionHeaderView"
        ) as? HomeSectionHeaderView
        else { return nil }
        
        let action = UIAction { _ in
            self.words.shuffle()
            DispatchQueue.main.async {
                self.homeWordTableView.reloadData()
            }
        }
        
        headerView.addActionToSuffleButton(action)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationBar = navigationController?.navigationBar
        else { return }
        
        let backButtonImage =  #imageLiteral(resourceName: "btn_back").withRenderingMode(.alwaysTemplate)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backIndicatorImage = backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationBar.tintColor = .primaryColor
        navigationBar.isTranslucent = true
        
        let fakeNavigationBar = UIView(frame: .zero)
        fakeNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        fakeNavigationBar.isUserInteractionEnabled = false
        fakeNavigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        fakeNavigationBar.isHidden = true
        
        view.insertSubview(fakeNavigationBar, belowSubview: navigationBar)
        fakeNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fakeNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fakeNavigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        show(VocaDetailViewController(), sender: self)
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
