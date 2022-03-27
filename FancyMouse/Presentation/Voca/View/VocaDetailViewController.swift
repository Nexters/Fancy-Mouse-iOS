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
    private let scrollFinishView = UIView()
    private let notificationCenter = NotificationCenter.default
    
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
    
    private lazy var vocaMemoView: VocaMemoView = {
        VocaMemoView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        view.backgroundColor = .white
        
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
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
        
        vocaMemoView.snp.makeConstraints { make in
            make.top.equalTo(togetherSavedSentenceView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        scrollFinishView.snp.makeConstraints { make in
            make.top.equalTo(vocaMemoView.snp.bottom).inset(10)
            make.height.equalTo(40)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(wordLabel)
        contentView.addSubview(wordCreatedDateLabel)
        contentView.addSubview(wordMeaningStackView)
        contentView.addSubview(wordDetailStackView)
        contentView.addSubview(contourView)
        contentView.addSubview(togetherSavedSentenceView)
        contentView.addSubview(vocaMemoView)
        scrollView.addSubview(scrollFinishView)
    }
}
