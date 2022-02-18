//
//  SearchViewController.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/17.
//

import RxCocoa
import RxSwift
import UIKit

final class SearchViewController: UIViewController {
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundImage = UIImage()
        bar.placeholder = "검색할 단어를 입력해 주세요."
        bar.setImage(UIImage(named: "searchBar"), for: .search, state: .normal)
        bar.setImage(UIImage(named: "clear"), for: .clear, state: .normal)
        bar.setPositionAdjustment(UIOffset(horizontal: 16, vertical: 0), for: .search)
        bar.setPositionAdjustment(UIOffset(horizontal: -16, vertical: 0), for: .clear)
        return bar
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.gray60, for: .normal)
        button.titleLabel?.font = .spoqaMedium(size: 16)
        return button
    }()
    
    private lazy var recentWordsLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색 단어"
        label.font = .spoqaBold(size: 16)
        label.textColor = .primaryColor
        return label
    }()
    
    private lazy var preViewTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray30
        tableView.separatorStyle = .none
        tableView.register(
            SearchAutoCompleteCell.self,
            forCellReuseIdentifier: "SearchAutoCompleteCell"
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinding()
    }
    
    private func setup() {
        view.backgroundColor = .gray30
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * 0.059)
            make.top.equalToSuperview().offset(45)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(66)
        }
        searchBar.searchTextField.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar)
            make.leading.equalTo(searchBar.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(24)
        }
        
        view.addSubview(recentWordsLabel)
        recentWordsLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(24)
        }
        
        view.addSubview(preViewTableView)
        preViewTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        let input = SearchViewModel.Input(
            searchTextInput: searchBar.rx.text.orEmpty
                .debounce(
                    RxTimeInterval.microseconds(5),
                    scheduler: MainScheduler.instance
                )
                .distinctUntilChanged()
        )
        let output = viewModel.transform(input: input)
        
        input.searchTextInput
            .bind { _ in
                self.preViewTableView.reloadData()
            }.disposed(by: disposeBag)
        
        output.searchResultOutput
            .bind(to: preViewTableView.rx.items) { (_, row, item) -> UITableViewCell in
                guard let cell = self.preViewTableView.dequeueReusableCell(
                    withIdentifier: "SearchAutoCompleteCell",
                    for: IndexPath.init(row: row, section: 0)
                ) as? SearchAutoCompleteCell else { return UITableViewCell() }
                
                cell.setupData(word: item.key, meaning: item.value)
                return cell
            }
            .disposed(by: self.disposeBag)
    }
}
