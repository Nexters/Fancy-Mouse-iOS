//
//  WalkthroughFirstViewController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/25.
//

import SnapKit
import UIKit

class WalkthroughFirstViewController: UIViewController {
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "슥 - 드래그 해서"
        label.textColor = .white
        label.font = .spoqaBold(size: 24)
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.text = """
        크롬익스텐션을 통해
        단어를 저장할 수 있어요.
        """
        label.textColor = .gray50
        label.font = .spoqaMedium(size: 16)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var pageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "_img_walkthrough_01")
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
