//
//  FolderViewController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import Firebase
import RxSwift
import UIKit

struct FolderUseCase: FolderUseCaseProtocol {
    func createFolder(folderName: String, folderColor: UIColor) {
        let testItemsReference = Database.database().reference(withPath: "users/sangjin/folders")
        let userItemRef = testItemsReference.child("3")
        let values: [String: Any] = [
            "color": "folder03",
            "createdAt": 12345,
            "folderId": "3",
            "folderName": "테스트폴더3"
        ]
        userItemRef.setValue(values)
    }
    
    func fetchFolder() -> Observable<[Folder]> {
        <#code#>
    }
    
    func update(folder: Folder, folderColor: String, folderName: String) {
        <#code#>
    }
    
    func delete(_ folderID: FolderID) {
        <#code#>
    }
    
}

final class FolderViewController: UIViewController {
    // MARK: dummy data
    private let webTempString = "www.naver.com"
    private let disposeBag = DisposeBag()
    private lazy var viewModel = FolderViewModel(useCase: FolderUseCase())
    private var test = BehaviorSubject<[Folder]>(value: .init())
    
    private lazy var explainView: UIView = {
        let view = UIView()
        view.backgroundColor = .explanColor
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var explainCountLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaBold(size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var explainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "개의 폴더"
        label.font = .spoqaMedium(size: 18)
        label.textColor = .white
        return label
    }()

    private lazy var explainSubLabel: UILabel = {
        let label = UILabel()
        label.text = "단어는 웹에서 등록할 수 있어요!"
        label.font = .spoqaMedium(size: 12)
        label.textColor = .gray50
        return label
    }()
    
    private lazy var explainPastButton: UIButton = {
        let button = UIButton()
        button.setTitle("링크 복사하기", for: .normal)
        button.titleLabel?.font = .spoqaMedium(size: 12)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -6)
        button.setTitleColor(.secondaryColor, for: .normal)
        button.setImage(UIImage(named: "copy"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        
        let action = UIAction { _ in
            UIPasteboard.general.string = self.webTempString
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var explainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "explainFolder")
        return imageView
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let collectionViewWidth = UIScreen.main.bounds.width - 48
        let widthSize = collectionViewWidth * 0.483
        let heightSize = widthSize * 0.917
        layout.minimumLineSpacing = 11
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .gray30
        collectionView.register(
            FolderCell.self,
            forCellWithReuseIdentifier: "FolderCell"
        )
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchFolder()
            .bind(to: test)
            .disposed(by: disposeBag)
        setupView()
        setupLayout()
        setupBinding()
    }
    
    private func setupView() {
        view.backgroundColor = .gray30
        
        view.addSubview(explainView)
        explainView.addSubview(explainCountLabel)
        explainView.addSubview(explainTitleLabel)
        explainView.addSubview(explainSubLabel)
        explainView.addSubview(explainImageView)
        explainView.addSubview(explainPastButton)
        
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        explainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(118)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(126)
        }
        
        explainCountLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(24)
        }
        
        explainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalTo(explainCountLabel.snp.trailing).offset(2)
        }
        
        explainSubLabel.snp.makeConstraints { make in
            make.top.equalTo(explainTitleLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(24)
        }
        
        explainPastButton.snp.makeConstraints { make in
            make.top.equalTo(explainSubLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
        }
        
        explainImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(39)
            make.trailing.equalToSuperview().inset(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(explainView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview().inset(24)
        }
    }
    
    private func setupBinding() {
        test
            .bind(to: collectionView.rx.items) { (_, row, item) -> UICollectionViewCell in
                print("ㄴㅇ매ㅑ룬야ㅐ루ㅑㅐㅇ누랴ㅐㅇ누랭나라ㅣㄴ")
                guard let cell = self.collectionView.dequeueReusableCell(
                    withReuseIdentifier: "FolderCell",
                    for: IndexPath.init(row: row, section: 0)
                ) as? FolderCell else { return UICollectionViewCell() }
                guard let itemColor = item.folderColor else { return UICollectionViewCell() }
                cell.setupData(title: item.folderName, count: item.wordCount, color: itemColor)
                return cell
            }
            .disposed(by: self.disposeBag)
        
        viewModel.folderCount
            .bind { [weak self] count in
                self?.explainCountLabel.text = "\(count)"
            }
            .disposed(by: disposeBag)
    }
}
