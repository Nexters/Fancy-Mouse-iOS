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
    let homeViewModel = HomeViewModel(useCase: HomeViewUseCase())
    var words: [Word] = []
    
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
//        view.addSubview(progressView)
        view.addSubview(homeWordTableView)
//        progressView.translatesAutoresizingMaskIntoConstraints = false
        homeWordTableView.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint.activate([
//            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
//        ])
        
        NSLayoutConstraint.activate([
            homeWordTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            homeWordTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            homeWordTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            homeWordTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0, let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeProgressView") as? HomeProgressView else { return nil }
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 305
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWordCell", for: indexPath) as? HomeWordCell else { return UITableViewCell() }
        
        let cellViewModel = HomeWordCellViewModel(useCase: HomeWordUseCase(), word: words[indexPath.row], hidingStatusRelay: BehaviorRelay<HomeViewModel.HidingStatus>(value: .none))
        cell.configure(viewModel: cellViewModel)
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

struct HomeWordUseCase: HomeWordUseCaseProtocol {
    func changeMemorizationStatus(to newStatus: Word.MemorizationStatus, of wordID: WordID) -> Observable<Word> {
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
