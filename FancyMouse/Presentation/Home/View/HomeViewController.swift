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
        tableView.register(
            HomeWordCell.self,
            forCellReuseIdentifier: "HomeWordCell"
        )
        tableView.register(
            HomeProgressView.self,
            forHeaderFooterViewReuseIdentifier: "HomeProgressView"
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
        for idx in (0...4) {
            let spellings = ["ABCD", "ZBBD", "EBCD", "DEFQ", "DDDD"]
            let dates = [Date(timeIntervalSinceNow: -1000),
                         Date(timeIntervalSinceNow: -10),
                         Date(timeIntervalSinceNow: -30050),
                         Date(timeIntervalSinceNow: -3040500),
                         Date(timeIntervalSinceNow: -30)]
            let word = Word(id: idx, folderID: 0, createdAt: dates[idx], spelling: spellings[idx], meanings: ["sadf", "sdfjksd"], memorizationStatus: .incomplete, memo: nil, synonyms: ["sdf"], examples: ["sdf"], urlString: "dsf")
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
