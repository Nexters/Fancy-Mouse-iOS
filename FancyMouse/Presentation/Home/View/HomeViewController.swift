//
//  HomeViewController.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/22.
//

import SnapKit
import UIKit

final class HomeViewController: UIViewController {
    private let userName: String = "수진"
    private let progressPercent: Int = 0
    private let wordCount: Int = 0
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gradientBack
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "\(userName)님,"
        label.font = .spoqaRegular(size: 20)
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "\(progressPercent)% 외웠어요!"
        label.font = .spoqaRegular(size: 20)
        return label
    }()
    
    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "\(wordCount) 개 / 200 개"
        label.font = .spoqaBold(size: 12)
        label.textColor = UIColor.gray30
        return label
    }()
    
    private lazy var progressImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "progressIcon")
        return imageView
    }()
    
    private lazy var entryButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "btn_entry")
        button.setImage(image, for: .normal)
        let entryAction = UIAction() { _ in
        }
        button.addAction(entryAction, for: .touchUpInside)
        return button
    }()
    
    private lazy var gradientView: UIView = {
        var view = ProgressGradientView()
        view.backgroundColor = UIColor.gradientBack
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPercentFont()
    }

    private func setupPercentFont() {
        let fullText = percentLabel.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "\(progressPercent)%")
        attribtuedString.addAttribute(.foregroundColor,
                                      value: UIColor.secondaryColor,
                                      range: range)
        percentLabel.attributedText = attribtuedString
    }
    
    private func setupUI() {
        self.view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.height.equalTo(305)
            make.top.equalToSuperview().inset(104)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        progressView.addSubview(userLabel)
        userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        progressView.addSubview(percentLabel)
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(24)
        }
        
        progressView.addSubview(wordLabel)
        wordLabel.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(24)
        }

        progressView.addSubview(entryButton)
        entryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.width.equalTo(24)
        }
        
        progressView.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(124)
            make.trailing.leading.equalToSuperview().inset(24)
            make.height.width.equalTo(152)
        }
        
        progressView.addSubview(progressImageView)
        progressImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(163)
            make.height.width.equalTo(63)
        }
    }
}
