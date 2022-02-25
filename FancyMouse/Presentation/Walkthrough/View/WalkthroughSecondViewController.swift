//
//  WalkthroughSecondViewController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/25.
//

import UIKit

class WalkthroughSecondViewController: UIViewController {
    
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "내가 알고싶은 단어만 모아"
        label.textColor = .white
        label.font = .spoqaBold(size: 24)
        return label
    }()
    
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.text = """
        단어가 포함된 문장까지 저장되어,
        함께 확인할 수 있어요.
        """
        label.textColor = .gray50
        label.font = .spoqaRegular(size: 16)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var pageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "_img_walkthrough_02")
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(mainTitle)
        self.view.addSubview(subTitle)
        self.view.addSubview(pageImageView)
        mainTitle.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(24)
        }
        
        pageImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }
}
