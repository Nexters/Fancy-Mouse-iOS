//
//  VocaDetailViewController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/24.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class VocaDetailViewController: UIViewController {
    private let word: String = "Purpose"
    private let wordAddDate: String = "2022-01-23"
    private let prouncation: String = "[ ˈpɜːrpəs]"
    private let example: String = "In the meantime, the province magistrate provided supplies."
    private let synonym: String = "hide, hat, face, veil, disguise,camouflage"
    private let togetherSentence: String = "Our campaign’s main purpose is to raise money."
    private var myMemoDB: String = ""
    var wordMeanings: [String] = ["(이루고자 하는·이루어야 할) 목적",
                                  "(특정 상황에서 무엇을) 하기 위함, 용도, 의도",
                                  "결단력"]
    
    private var keyHeight: CGFloat?
    private let disposeBag = DisposeBag()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let wordView = UIView()
    private let scrollFinishView = UIView()
    private let notificationCenter = NotificationCenter.default
    
    private let saveAction = UIAction { _ in
    }
    
    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.text = word
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var wordCreatedDateLabel: UILabel = {
        let label = UILabel()
        label.text = wordAddDate
        label.font = label.font.withSize(12)
        label.textColor = .systemGray4
        label.textAlignment = .left
        return label
    }()
    
    private lazy var contourView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.933, green: 0.945, blue: 0.957, alpha: 1)
        return view
    }()
    
    private lazy var wordMeaningStackView: WordMeaningsStackView = {
        let stackView = WordMeaningsStackView()
        stackView.addSubMeaningViews(with: wordMeanings)
        return stackView
    }()
    
    private lazy var wordDetailStackView: WordDetailDescriptionsStackView = {
        let stackView = WordDetailDescriptionsStackView()
        stackView.addSubDescriptionViews(with: [
            WordDetailDescription(title: "발음", description: prouncation, color: .folder02),
            WordDetailDescription(title: "예문", description: example, color: .folder03),
            WordDetailDescription(title: "동의어", description: synonym, color: .folder04)
        ])
        return stackView
    }()
    
    private lazy var togetherSavedSentenceView: TogetherSavedSentenceView = {
        let togetherSavedSentenceView = TogetherSavedSentenceView()
        togetherSavedSentenceView.sentence = togetherSentence
        
        return togetherSavedSentenceView
    }()
    
    private lazy var myMemoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.primaryDark.cgColor
        return view
    }()
    
    private lazy var myMemoLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 남긴 메모"
        label.textColor = .gray60
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var myMemoDBLabel: UILabel = {
        let label = UILabel()
        label.text = myMemoDB
        label.textColor = .primaryDark
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var myMemotextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private lazy var myMemoSaveButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 61, height: 28)
        button.layer.backgroundColor = UIColor.gray30.cgColor
        button.layer.cornerRadius = 6
        button.setTitle("수정하기", for: .normal)
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addAction(saveAction, for: .touchUpInside)
        return button
    }()
    
    private lazy var numberOfMemoLabel: UILabel = {
        let label = UILabel()
        let numberOfMemo = String(myMemoDB.count)
        label.text = "\(numberOfMemo) / 140자"
        label.textColor = .gray50
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setup()
        setupTextField()
    }
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue
            = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.scrollView.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.scrollView.frame.origin.y += keyboardHeight
        }
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
}

private extension VocaDetailViewController {
    func setupUI() {
        addSubViews()
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        wordView.backgroundColor = .white
        
        wordView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(800)
        }
        
        wordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(74)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        wordCreatedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(wordLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        wordMeaningStackView.snp.makeConstraints { make in
            make.top.equalTo(wordCreatedDateLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        wordDetailStackView.snp.makeConstraints { make in
            make.top.equalTo(wordMeaningStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        contourView.snp.makeConstraints { make in
            make.top.equalTo(wordMeaningStackView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        togetherSavedSentenceView.snp.makeConstraints { make in
            make.top.equalTo(wordDetailStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(116)
        }
        
        myMemoView.snp.makeConstraints { make in
            make.top.equalTo(togetherSavedSentenceView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(92)
        }
        
        myMemoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(24)
        }
        
        myMemotextField.snp.makeConstraints { make in
            make.top.equalTo(myMemoLabel.snp.bottom).offset(12)
            make.bottom.equalTo(myMemoView.snp.bottom).offset(-12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(myMemoView.snp.trailing).offset(-12)
        }
        
        myMemoSaveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(28)
            make.width.equalTo(61)
        }
        
        numberOfMemoLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(16)
        }
        
        scrollFinishView.snp.makeConstraints { make in
            make.top.equalTo(myMemoView.snp.bottom).inset(10)
            make.height.equalTo(10)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(wordView)
        wordView.addSubview(wordLabel)
        wordView.addSubview(wordCreatedDateLabel)
        wordView.addSubview(wordMeaningStackView)
        wordView.addSubview(wordDetailStackView)
        wordView.addSubview(contourView)
        wordView.addSubview(togetherSavedSentenceView)
        wordView.addSubview(myMemoView)
        myMemoView.addSubview(myMemoLabel)
        myMemoView.addSubview(myMemotextField)
        myMemoView.addSubview(myMemoSaveButton)
        myMemoView.addSubview(numberOfMemoLabel)
        scrollView.addSubview(scrollFinishView)
    }

    func setup() {
        if myMemoDB.isEmpty == true {
            myMemotextField.placeholder = "남긴 메모가 없어요."
            myMemoView.layer.borderColor = UIColor.gray30.cgColor
            numberOfMemoLabel.isHidden = true
        } else {
            numberOfMemoLabel.isHidden = false
            myMemotextField.text = myMemoDB
            myMemotextField.textColor = .primaryDark
        }
    }
    
    func setupTextField() {
        self.myMemotextField.rx.controlEvent([.editingChanged])
            .asObservable()
            .subscribe(onNext: { _ in
                self.myMemoSaveButton.layer.backgroundColor = UIColor.primaryDark.cgColor
                self.myMemoSaveButton.layer.cornerRadius = 6
                self.myMemoSaveButton.setTitle("저장하기", for: .normal)
                self.myMemoSaveButton.titleLabel?.textColor = .secondaryLabel
                self.myMemoSaveButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                self.numberOfMemoLabel.isHidden = false
            }).disposed(by: disposeBag)
        
        self.myMemotextField.rx.text
            .subscribe(onNext: { [weak self] newValue in
                self?.myMemoDB = newValue ?? ""
                let number = String(newValue?.count ?? 0)
                self?.numberOfMemoLabel.text = "\(number) / 140 자"
            }).disposed(by: disposeBag)
    }
}
