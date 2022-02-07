//
//  LoginViewController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/05.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    let action = UIAction { _ in
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private lazy var welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다."
        label.textColor = UIColor(red: 177 / 255, green: 184 / 255, blue: 192 / 255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .custom, primaryAction: action)
        button.setTitle("Google로 계속", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 80 / 255, green: 88 / 255, blue: 102 / 255, alpha: 1)
        button.layer.cornerRadius = 12
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private func setUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(welcomeTitleLabel)
        welcomeTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(164)
            make.leading.equalToSuperview().offset(24)
        }
    
        view.addSubview(googleLoginButton)
        googleLoginButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
}
