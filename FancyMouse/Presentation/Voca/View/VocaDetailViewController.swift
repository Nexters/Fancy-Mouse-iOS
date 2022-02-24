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
    private let togetherSentence: String = "Our campaign is to raise money."
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

     private lazy var wordAddDateLabel: UILabel = {
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
    
    private lazy var wordMeaningStackView: UIStackView = {
        let stackView = WordMeaningsStackView()
        stackView.addSubMeaningViews(with: wordMeanings)
        return stackView
    }()
    
    private lazy var prouncationLabel: UILabel = {
        let label = UILabel()
        label.text = "발음"
        label.textColor = .folder02
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var prouncationAPILabel: UILabel = {
        let label = UILabel()
        label.text = prouncation
        label.textColor = .gray60
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var exampleLabel: UILabel = {
        let label = UILabel()
        label.text = "예문"
        label.textColor = .folder03
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var exampleAPILabel: UILabel = {
        let label = UILabel()
        label.text = example
        label.textColor = .gray60
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 5
        return label
    }()
    
    private lazy var synonymLabel: UILabel = {
        let label = UILabel()
        label.text = "동의어"
        label.textColor = .folder04
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var synonymAPILabel: UILabel = {
        let label = UILabel()
        label.text = synonym
        label.textColor = .gray60
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 5
        return label
    }()
    
    private lazy var togetherSaveView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray30
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var togetherLabel: UILabel = {
        let label = UILabel()
        label.text = "함께 저장한 문장"
        label.textColor = .gray60
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var togetherAPILabel: UILabel = {
        let label = UILabel()
        label.text = togetherSentence
        label.textColor = .primaryDark
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var myMemoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.primaryDark?.cgColor
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
        button.layer.backgroundColor = UIColor.gray30?.cgColor
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
         NotificationCenter.default.addObserver(self,
                                                selector: #selector(self.keyboardWillShow(_:)),
                                                name: UIResponder.keyboardWillShowNotification , object: nil)
         NotificationCenter.default.addObserver(self,
                                                selector: #selector(self.keyboardWillHide(_:)),
                                                name: UIResponder.keyboardWillHideNotification, object: nil)
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

    private func setupUI() {
         view.addSubview(scrollView)
         
         scrollView.snp.makeConstraints { (make) in
             make.edges.equalToSuperview()
         }
         
         scrollView.addSubview(contentView)
         contentView.snp.makeConstraints { (make) in
             make.width.equalToSuperview()
             make.centerX.top.bottom.equalToSuperview()
         }
         
         self.contentView.addSubview(wordView)
         wordView.backgroundColor = .white
         
         wordView.snp.makeConstraints { (make) in
             make.leading.top.trailing.equalToSuperview()
             make.height.equalTo(800)
         }
   
         wordView.addSubview(wordLabel)
         wordLabel.snp.makeConstraints { make in
             make.top.equalToSuperview().inset(74)
             make.leading.trailing.equalToSuperview().inset(24)
         }
         wordView.addSubview(wordAddDateLabel)
         wordAddDateLabel.snp.makeConstraints { make in
             make.top.equalTo(wordLabel.snp.bottom).offset(12)
             make.leading.trailing.equalToSuperview().inset(24)
         }
        
        wordView.addSubview(wordMeaningStackView)
        wordMeaningStackView.snp.makeConstraints { make in
            make.top.equalTo(wordAddDateLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
         wordView.addSubview(contourView)
         contourView.snp.makeConstraints { make in
             make.top.equalTo(wordMeaningStackView.snp.bottom).offset(12)
             make.leading.trailing.equalToSuperview().inset(24)
             make.height.equalTo(1)
         }
         
         wordView.addSubview(prouncationLabel)
         prouncationLabel.snp.makeConstraints { make in
             make.top.equalTo(contourView.snp.bottom).offset(24)
             make.leading.equalToSuperview().inset(24)
         }
         
         wordView.addSubview(prouncationAPILabel)
         prouncationAPILabel.snp.makeConstraints { make in
             make.top.equalTo(contourView.snp.bottom).offset(24)
             make.leading.equalTo(prouncationLabel.snp.trailing).offset(25)
         }
         
         wordView.addSubview(exampleLabel)
         exampleLabel.snp.makeConstraints { make in
             make.top.equalTo(prouncationAPILabel.snp.bottom).offset(16)
             make.leading.equalToSuperview().inset(24)
         }
         
         wordView.addSubview(exampleAPILabel)
         exampleAPILabel.snp.makeConstraints { make in
             make.top.equalTo(prouncationAPILabel.snp.bottom).offset(16)
             make.leading.equalTo(exampleLabel.snp.trailing).offset(25)
             make.trailing.equalToSuperview().inset(24)
         }
         
         wordView.addSubview(synonymLabel)
         synonymLabel.setContentCompressionResistancePriority(.init(rawValue: 751),
                                                              for: .horizontal)
         synonymLabel.snp.makeConstraints { make in
             make.top.equalTo(exampleAPILabel.snp.bottom).offset(16)
             make.leading.equalToSuperview().inset(24)
         }
         
         wordView.addSubview(synonymAPILabel)
         synonymAPILabel.snp.makeConstraints { make in
             make.top.equalTo(exampleAPILabel.snp.bottom).offset(16)
             make.leading.equalTo(synonymLabel.snp.trailing).offset(12)
             make.trailing.equalToSuperview().inset(24)
         }

         wordView.addSubview(togetherSaveView)
         togetherSaveView.snp.makeConstraints { make in
             make.top.equalTo(synonymAPILabel.snp.bottom).offset(24)
             make.leading.trailing.equalToSuperview().inset(24)
             make.height.equalTo(116)
         }

         togetherSaveView.addSubview(togetherLabel)
         togetherLabel.snp.makeConstraints { make in
             make.top.equalToSuperview().inset(20)
             make.leading.equalToSuperview().inset(24)
         }

         togetherSaveView.addSubview(togetherAPILabel)
         togetherAPILabel.snp.makeConstraints { make in
             make.top.equalTo(togetherLabel.snp.bottom).offset(12)
             make.leading.trailing.equalToSuperview().inset(24)
         }

         wordView.addSubview(myMemoView)
         myMemoView.snp.makeConstraints { make in
             make.top.equalTo(togetherSaveView.snp.bottom).offset(12)
             make.leading.trailing.equalToSuperview().inset(24)
             make.height.equalTo(92)
         }

         myMemoView.addSubview(myMemoLabel)
         myMemoLabel.snp.makeConstraints { make in
             make.top.equalToSuperview().inset(20)
             make.leading.equalToSuperview().inset(24)
         }

        myMemoView.addSubview(myMemotextField)
        myMemotextField.snp.makeConstraints { make in
            make.top.equalTo(myMemoLabel.snp.bottom).offset(12)
            make.bottom.equalTo(myMemoView.snp.bottom).offset(-12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(myMemoView.snp.trailing).offset(-12)
        }
        
        myMemoView.addSubview(myMemoSaveButton)
        myMemoSaveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(28)
            make.width.equalTo(61)
        }
        
        myMemoView.addSubview(numberOfMemoLabel)
        numberOfMemoLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(16)
        }
        
        scrollView.addSubview(scrollFinishView)
        scrollFinishView.snp.makeConstraints { make in
            make.top.equalTo(myMemoView.snp.bottom).inset(10)
            make.height.equalTo(10)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension VocaDetailViewController {
    private func setup() {
        if myMemoDB.isEmpty == true {
            myMemotextField.placeholder = "남긴 메모가 없어요."
            myMemoView.layer.borderColor = UIColor.gray30?.cgColor
            numberOfMemoLabel.isHidden = true
        } else {
            numberOfMemoLabel.isHidden = false
            myMemotextField.text = myMemoDB
            myMemotextField.textColor = .primaryDark
        }
    }
    
    private func setupTextField() {
        self.myMemotextField.rx.controlEvent([.editingChanged])
            .asObservable()
            .subscribe(onNext: { _ in
                self.myMemoSaveButton.layer.backgroundColor = UIColor.primaryDark?.cgColor
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
