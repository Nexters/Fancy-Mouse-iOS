//
//  FolderViewController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class FolderViewController: UIViewController {
    private var folderCount = 12
    private var disposeBag = DisposeBag()
    
    // MARK: dummy data
    private let folderNameList = [ "폴더1", "수능영어", "토익단어", "TOEFL"]
    private var webTempString = "www.naver.com"
    
    private lazy var emojiView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "\(folderCount)"
        label.font = label.font.withSize(20)
        label.textColor = .white
        return label
    }()
    
    private lazy var countExplainLabel: UILabel = {
        let label = UILabel()
        label.text = "개의 폴더"
        label.font = label.font.withSize(18)
        label.textColor = .white
        return label
    }()

    private lazy var webExplainLabel: UILabel = {
        let label = UILabel()
        label.text = "단어는 웹에서 등록할 수 있어요!"
        label.font = label.font.withSize(12)
        label.textColor = UIColor.gray40
        return label
    }()
    
    private lazy var pasteImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_copy")
        return image
    }()
    
    private lazy var pasteLabel: UILabel = {
        let label = UILabel()
        label.text = "링크 복사하기"
        label.font = label.font.withSize(12)
        label.textColor = UIColor.secondaryDark
        return label
    }()
    
    private lazy var pasteButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var folderImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Folder")
        return image
    }()
    
    private var folderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }
    
    private func setup() {
        folderCollectionView.delegate = self
        folderCollectionView.dataSource = self
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.gray50
        view.addSubview(folderCollectionView)
        folderCollectionView.register(FolderCell.self, forCellWithReuseIdentifier: "FolderCell")
        
        self.view.addSubview(self.emojiView)
        self.emojiView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(126)
        }
        
        self.emojiView.addSubview(self.countLabel)
        self.countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        self.emojiView.addSubview(self.countExplainLabel)
        self.countExplainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.equalTo(countLabel.snp.trailing).offset(2)
        }
        
        self.emojiView.addSubview(self.webExplainLabel)
        self.webExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(countExplainLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().inset(24)
        }
        
        self.emojiView.addSubview(self.pasteImageView)
        pasteImageView.snp.makeConstraints { make in
            make.top.equalTo(webExplainLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(24)
        }
        
        self.emojiView.addSubview(self.pasteLabel)
        self.pasteLabel.snp.makeConstraints { make in
            make.top.equalTo(webExplainLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(45)
        }
        
        self.emojiView.addSubview(self.folderImageView)
        self.folderImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(47)
            make.trailing.equalToSuperview().inset(30)
        }
        
        self.emojiView.addSubview(self.pasteButton)
        self.pasteButton.snp.makeConstraints { make in
            make.top.equalTo(webExplainLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalTo(folderImageView.snp.leading).offset(140)
        }
        
        pasteButton.rx.tap
            .bind(onNext: {
                UIPasteboard.general.string = self.webTempString
            }).disposed(by: disposeBag)

        self.view.addSubview(self.folderCollectionView)
        self.folderCollectionView.snp.makeConstraints { make in
            make.top.equalTo(emojiView.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
        }
    }
}

extension FolderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 11
        let width: CGFloat = self.folderCollectionView.frame.width / 2 - itemSpacing
        return CGSize(width: width, height: width * 0.917)
     }
}

extension FolderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return folderNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FolderCell.identifier, for: indexPath
        ) as? FolderCell else {
            fatalError()
        }
        cell.layer.cornerRadius = 20
        return cell
    }
}
