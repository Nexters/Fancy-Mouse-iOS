//
//  FolderViewController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import Firebase
import RxSwift

final class FolderViewController: UIViewController, BottomSheetDelegate {
    private lazy var viewModel = FolderViewModel(useCase: FolderUseCase())
    private let disposeBag = DisposeBag()
    
    private var ellipsisView: EllipsisView?
    private var selectedFolder: Folder?
    private var folderAddEditView = FolderAddEditView()
    
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
            UIPasteboard.general.string = "www.google.com"
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
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 11
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(collectionViewWasTapped(sender:))
        )
        collectionView.backgroundColor = .gray30
        collectionView.addGestureRecognizer(tap)
        collectionView.register(
            FolderCell.self,
            forCellWithReuseIdentifier: "FolderCell"
        )
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupBinding()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ellipsisView?.removeFromSuperview()
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
            make.width.lessThanOrEqualTo(24)
        }
        
        explainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalTo(explainCountLabel.snp.trailing).offset(2)
            make.width.equalTo(71)
        }
        
        explainSubLabel.snp.makeConstraints { make in
            make.top.equalTo(explainTitleLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(170)
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
        viewModel.fetchFolder()
            .bind(to: collectionView.rx.items) { (_, row, item) -> UICollectionViewCell in
                guard let cell = self.collectionView.dequeueReusableCell(
                    withReuseIdentifier: "FolderCell",
                    for: IndexPath.init(row: row, section: 0)
                ) as? FolderCell else { return UICollectionViewCell() }
                guard let itemColor = item.folderColor else { return UICollectionViewCell() }
                self.selectedFolder = item
                
                cell.moreButton.addTarget(self,
                                          action: #selector(self.moreButtonWasTapped(_:)),
                                          for: .touchUpInside
                )
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
    
    //TODO: 리팩기간에 로직 수정하기
    @objc private func moreButtonWasTapped(_ sender: UIButton) {
        ellipsisView?.removeFromSuperview()
        let view: EllipsisView = {
            let view = EllipsisView()
            
            if let folder = selectedFolder, let color = folder.folderColor {
                view.addComponent(title: "수정하기", imageName: "edit", action: UIAction { _ in
                    self.moreButtonEditWasTapped(folderName: folder.folderName, folderColor: color)
                })
                view.addComponent(title: "삭제하기", imageName: "delete", action: UIAction { _ in
                    self.moreButtonDeleteWasTapped(folderID: folder.folderID, wordCount: folder.wordCount)
                })
            }
            return view
        }()
        
        ellipsisView = view
        self.view.addSubview(ellipsisView ?? UIView())
        ellipsisView?.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(100)
            make.top.equalTo(sender.snp.bottom).offset(8)
            make.trailing.equalTo(sender.snp.trailing).offset(6)
        }
    }
    
    //TODO: 리팩 기간에 유스케이스+뷰모델로 빼기
    private func moreButtonEditWasTapped(folderName: String, folderColor: UIColor) {
        let view = BottomSheetController(
            contentView: folderAddEditView,
            title: "폴더 수정하기",
            topInset: 40,
            bottomInset: 40
        )
        view.setup(parentViewController: self)
        view.delegate = self
    }
    private func moreButtonDeleteWasTapped(folderID: Int, wordCount: Int) {
        let view = DeletionAlertViewController(target: "폴더", wordCount: 3)
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        self.present(view, animated: true, completion: nil)
    }
    
    @objc private func collectionViewWasTapped(sender: UITapGestureRecognizer) {
        ellipsisView?.removeFromSuperview()
    }
    
    func closeWasTapped() {}
    
    func okWasTapped() {
        guard let folder = selectedFolder else { return }
        viewModel.update(folder: folder, folderColor: <#T##String#>, folderName: <#T##String#>)
    }
}
