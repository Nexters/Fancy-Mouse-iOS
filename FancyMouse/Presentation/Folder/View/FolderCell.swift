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
    static let identifier = "FolderCell"
    private let disposeBag = DisposeBag()
    private var currentFolderNum: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    var folderImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "FolderImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var moreImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "more")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var folderName: UILabel = {
        let folderName = UILabel()
        folderName.text = "폴더1"
        folderName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        folderName.textColor = .darkGray
        folderName.translatesAutoresizingMaskIntoConstraints = false
        return folderName
    }()
    
    var wordCount: UILabel = {
        let wordCount = UILabel()
        wordCount.text = "32"
        wordCount.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        wordCount.textColor = .darkGray
        wordCount.translatesAutoresizingMaskIntoConstraints = false
        return wordCount
    }()
    
    private func setupUI() {
        self.backgroundColor = .white
        self.addSubview(folderName)
        folderName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.leading.equalToSuperview().offset(24)
        }
        
        self.addSubview(wordCount)
        wordCount.snp.makeConstraints { make in
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
