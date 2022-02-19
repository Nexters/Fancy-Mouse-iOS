//
//  FolderCell.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import RxCocoa
import RxSwift
import UIKit

class FolderCell: UICollectionViewCell {
    static let identifier = String(describing: FolderCell.self)
    private let disposeBag = DisposeBag()
    private var currentFolderNum: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    var folderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FolderImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var moreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "more")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var folderNameLabel: UILabel = {
        let label = UILabel()
        label.text = "폴더1"
        label.font = .spoqaBold(size: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var wordCountLabel: UILabel = {
        let label = UILabel()
        label.text = "32"
        label.font = .spoqaRegular(size: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupUI() {
        self.backgroundColor = .white
        self.addSubview(folderNameLabel)
        folderNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.leading.equalToSuperview().offset(24)
        }
        
        self.addSubview(wordCountLabel)
        wordCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(108)
            make.leading.equalToSuperview().offset(24)
        }
        
        self.addSubview(folderImageView)
        folderImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        self.addSubview(moreImageView)
        moreImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21.5)
            make.trailing.equalToSuperview().offset(-20.5)
        }
    }
}
