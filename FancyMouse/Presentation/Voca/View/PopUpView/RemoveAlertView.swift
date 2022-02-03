//
//  RemoveAlertView.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/04.
//

import UIKit

protocol RemoveAlertDelegate: AnyObject {
    func cancelWasTapped()
    func acceptWasTapped()
}

final class RemoveAlertViewController: UIViewController {
    private let removeWordCount: Int
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "선택한 폴더를 정말 삭제하시겠어요?"
        label.textColor = UIColor(red: 80 / 255, green: 88 / 255, blue: 102 / 255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "폴더 안의 \(removeWordCount)개 단어도 함께 삭제돼요."
        label.textColor = UIColor(red: 136 / 255, green: 145 / 255, blue: 160 / 255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor(red: 80 / 255, green: 88 / 255, blue: 102 / 255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 242 / 255, green: 244 / 255, blue: 246 / 255, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancelWasTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 80 / 255, green: 88 / 255, blue: 102 / 255, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(acceptWasTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: RemoveAlertDelegate?
    
    init(removeWordCount: Int) {
        self.removeWordCount = removeWordCount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(alertView)
        alertView.snp.makeConstraints { make in
            make.width.equalTo(335)
            make.centerY.centerX.equalToSuperview()
            
            if removeWordCount != 0 {
                make.height.equalTo(190)
            } else {
                make.height.equalTo(158)
            }
        }
        
        alertView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        
        if removeWordCount != 0 {
            alertView.addSubview(subLabel)
            subLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(12)
                make.centerX.equalToSuperview()
            }
        }
        
        alertView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(144)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        alertView.addSubview(acceptButton)
        acceptButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(144)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @objc private func cancelWasTapped() {
        defer { dismiss(animated: true, completion: nil) }
        delegate?.cancelWasTapped()
    }
    
    @objc private func acceptWasTapped() {
        defer { dismiss(animated: true, completion: nil) }
        delegate?.acceptWasTapped()
    }
}
