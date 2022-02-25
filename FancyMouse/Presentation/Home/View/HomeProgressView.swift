//
//  HomeProgressView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/25.
//

import SnapKit
import UIKit

final class HomeProgressView: UIView {
    private let userName = "수진"
    private let progressPercent = 75
    private let wordCount = 20
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .gradientBack
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
        label.textColor = .gray30
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
        view.backgroundColor = .gradientBack
        return view
    }()

    init() {
        super.init(frame: .zero)
        
        setupPercentFont()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        addSubview(progressView)
        progressView.addSubview(userLabel)
        progressView.addSubview(percentLabel)
        progressView.addSubview(wordLabel)
        progressView.addSubview(entryButton)
        progressView.addSubview(gradientView)
        progressView.addSubview(progressImageView)
        
        progressView.snp.makeConstraints { make in
            make.height.equalTo(305)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(24)
        }
       
        wordLabel.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(24)
        }

        entryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.width.equalTo(24)
        }
        
        gradientView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(124)
            make.trailing.leading.equalToSuperview().inset(24)
            make.height.width.equalTo(152)
        }
        
        progressImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(163)
            make.height.width.equalTo(63)
        }
    }
}
