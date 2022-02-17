//
//  Created by suding on 2022/02/07.
//

import UIKit
import RxCocoa
import RxSwift

class FolderCell: UICollectionViewCell {
    static let identifier = "FolderCell"
    private let disposeBag = DisposeBag()
    private var currentFolderNum: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetting() {
        self.backgroundColor = UIColor.white
        self.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var folderImage: UIImageView = {
        let folderImage = UIImageView()
        folderImage.image = UIImage(named: "FolderImage")
        folderImage.translatesAutoresizingMaskIntoConstraints = false
        return folderImage
    }()
    
    var moreImage: UIImageView = {
        let listImage = UIImageView()
        listImage.image = UIImage(named: "more")
        listImage.translatesAutoresizingMaskIntoConstraints = false
        return listImage
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
        
        self.addSubview(folderImage)
        folderImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        self.addSubview(moreImage)
        moreImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21.5)
            make.trailing.equalToSuperview().offset(-20.5)
        }
    }
    
    
}
