//
//  RemoveAlertView.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/04.
//

import UIKit

protocol DeletionAlertDelegate: AnyObject {
    func cancelWasTapped()
    func deleteWasTapped(id: String)
}

final class DeletionAlertViewController: UIViewController {
    private let deleteID: String
    private let deleteTarget: String
    private let deleteWordCount: Int?
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이 \(deleteTarget)를 정말 삭제하시겠어요?"
        label.textColor = .primaryColor
        label.font = .spoqaBold(size: 18)
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray60
        label.font = .spoqaMedium(size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("아니요", for: .normal)
        button.setTitleColor(.gray60, for: .normal)
        button.titleLabel?.font = .spoqaMedium(size: 14)
        button.backgroundColor = .gray30
        button.layer.cornerRadius = 10
        let action = UIAction { _ in
            self.delegate?.cancelWasTapped()
            self.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제하기", for: .normal)
        button.setTitleColor(.secondaryColor, for: .normal)
        button.titleLabel?.font = .spoqaMedium(size: 14)
        button.backgroundColor = .primaryColor
        button.layer.cornerRadius = 10
        let action = UIAction { _ in
            self.delegate?.deleteWasTapped(id: self.deleteID)
            self.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    weak var delegate: DeletionAlertDelegate?
    
    init(id: String, target: String, wordCount: Int?) {
        self.deleteID = id
        self.deleteTarget = target
        self.deleteWordCount = wordCount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupSubLabel()
    }
}

private extension DeletionAlertViewController {
    func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(acceptButton)
    }
    
    func setupLayout() {
        alertView.snp.makeConstraints { make in
            make.width.equalTo(315)
            make.height.equalTo(161)
            make.centerY.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        
        acceptButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(132)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(132)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func setupSubLabel() {
        if deleteWordCount == 0 { return }
            
        subLabel.text = deleteWordCount == nil ? "한 번 삭제된 단어는 복구할 수 없어요." : "폴더 안의 \(deleteWordCount ?? 0)개의 단어도 함께 삭제돼요."
        
        alertView.addSubview(subLabel)
        alertView.snp.updateConstraints { make in
            make.height.equalTo(193)
        }
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        guard let subLabeltext = subLabel.text, let count = deleteWordCount else { return }
        
        let subLabelAttributedString = NSMutableAttributedString
            .Builder()
            .withString(subLabeltext)
            .withForegroundColor(.primaryColor)
            .withRange(from: subLabeltext, end: String(count))
            .build()
        
        subLabel.attributedText = subLabelAttributedString
    }
}
