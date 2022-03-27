//
//  SearchViewController.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/17.
//

import RxCocoa
import RxSwift

final class SearchViewController: UIViewController {
    private var searchTextInput: String?
    private var recentSearchIsEmpty: Bool?
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
        label.isHidden = true
        return label
    }()
    
    private lazy var autoCompleteTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray30
        tableView.separatorStyle = .none
        tableView.register(
            SearchAutoCompleteCell.self,
            forCellReuseIdentifier: "SearchAutoCompleteCell"
        )
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var recentSearchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray30
        tableView.separatorStyle = .none
        tableView.rowHeight = 44
        tableView.register(
            SearchRecentWordsCell.self,
            forCellReuseIdentifier: "SearchRecentWordsCell"
        )
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 16)
        label.textColor = .gray50
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinding()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
        
        view.addSubview(autoCompleteTableView)
        autoCompleteTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(recentSearchTableView)
        recentSearchTableView.snp.makeConstraints { make in
            make.top.equalTo(recentWordsLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(centerLabel)
        centerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.337)
            make.centerX.equalToSuperview()
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
        
        input.searchTextInput
            .bind { str in
                self.searchTextInput = str
                self.autoCompleteTableView.reloadData()
                str.isEmpty ? self.setupRecentSearchUI() : self.setupAutoCompleteUI()
            }.disposed(by: disposeBag)
        
        let output = viewModel.transform(input: input)
        
        output.searchResultOutput
            .bind(to: autoCompleteTableView.rx.items) { (_, row, item) -> UITableViewCell in
                guard let cell = self.autoCompleteTableView.dequeueReusableCell(
                    withIdentifier: "SearchAutoCompleteCell",
                    for: IndexPath.init(row: row, section: 0)
                ) as? SearchAutoCompleteCell else { return UITableViewCell() }
                
                cell.setupData(
                    word: item.key,
                    meaning: item.value,
                    inputText: self.searchTextInput ?? ""
                )
                return cell
            }
            .disposed(by: self.disposeBag)
        
        output.recentSearchWordsOutput
            .bind { item in
                self.recentSearchIsEmpty = item.isEmpty
            }
            .disposed(by: disposeBag)
        
        output.recentSearchWordsOutput
            .bind(to: recentSearchTableView.rx.items) { (_, row, item) -> UITableViewCell in
                guard let cell = self.recentSearchTableView.dequeueReusableCell(
                    withIdentifier: "SearchRecentWordsCell",
                    for: IndexPath.init(row: row, section: 0)
                ) as? SearchRecentWordsCell else { return UITableViewCell() }
                
                cell.setupData(word: item.key, date: item.value)
                return cell
            }
            .disposed(by: self.disposeBag)
        
        cancelButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: false) {
                    self.searchBar.searchTextField.text = ""
                    self.searchBar.endEditing(true)
                    self.setupRecentSearchUI()
                }
            }
            .disposed(by: disposeBag)
        
        searchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind {
                //TODO: 단어 컬렉션 뷰 전달받아서 검색 성공 케이스 구현 예정
                self.searchBar.resignFirstResponder()
                self.autoCompleteTableView.isHidden = true
                self.setupSearchFailUI()
            }
            .disposed(by: disposeBag)
    }
    
    private func setupRecentSearchUI() {
        if let empty = self.recentSearchIsEmpty {
            if empty {
                centerLabel.text = "최근 검색된 단어가 없어요."
                centerLabel.isHidden = false
            } else {
                recentWordsLabel.isHidden = false
                recentSearchTableView.isHidden = false
                autoCompleteTableView.isHidden = true
                centerLabel.isHidden = true
            }
        }
    }
    
    private func setupAutoCompleteUI() {
        recentWordsLabel.isHidden = true
        recentSearchTableView.isHidden = true
        autoCompleteTableView.isHidden = false
        centerLabel.isHidden = true
    }
    
    private func setupSearchFailUI() {
        centerLabel.isHidden = false
        
        if let text = self.searchTextInput {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            
            let resultString = "\(text)로 \n검색된 단어가 없어요."
            
            let attributedStr = NSMutableAttributedString(string: resultString)
            attributedStr.addAttribute(
                .foregroundColor,
                value: UIColor.primaryColor as Any,
                range: (resultString as NSString).range(of: text)
            )
            attributedStr.addAttribute(
                .font,
                value: UIFont.spoqaBold(size: 16) as Any,
                range: (resultString as NSString).range(of: text)
            )
            attributedStr.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: (resultString as NSString).range(of: resultString)
            )
            
            centerLabel.attributedText = attributedStr
            centerLabel.textAlignment = .center
        }
    }
}
