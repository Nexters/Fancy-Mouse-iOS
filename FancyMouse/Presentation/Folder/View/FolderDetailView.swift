//
//  FolderDetailView.swift
//  FancyMouse
//
//  Created by suding on 2022/02/25.
//

import SnapKit
import UIKit

final class FolderDetailView: UIViewController {
    private let folderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Folder")
        return imageView
    }()
    
    private let folderLabel: UILabel = {
        let label = UILabel()
        label.text = "폴더1"
        label.textColor = .primaryDark
        label.font = .spoqaBold(size: 24)
        label.textAlignment = .left
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "btn_select")
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        let action = UIAction { _ in
            // Action code
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(folderImageView)
        self.view.addSubview(folderLabel)
        self.view.addSubview(arrowImageView)
        self.view.addSubview(button)
        
        folderImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(118)
            make.height.equalTo(18)
            make.width.equalTo(24)
        }
        
        folderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalTo(folderImageView.snp.bottom).offset(20)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(folderLabel.snp.trailing)
            make.top.equalToSuperview().inset(168)
            make.height.equalTo(5.5)
            make.width.equalTo(11)
        }
        
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalTo(arrowImageView.snp.trailing)
            make.top.equalTo(folderImageView.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
    }
}
