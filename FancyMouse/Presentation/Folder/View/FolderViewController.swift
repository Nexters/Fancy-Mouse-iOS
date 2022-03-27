//
//  FolderViewController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import Firebase
import RxSwift

final class FolderViewController: UIViewController {
    private lazy var viewModel = FolderViewModel(useCase: FolderUseCase())
    private let disposeBag = DisposeBag()
    private var ellipsisView: EllipsisView?
    
    private lazy var explainView: UIView = {
        let view = UIView()
        view.backgroundColor = .explainColor
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
        collectionView.backgroundColor = .gray30
        collectionView.registerCell(ofType: FolderCell.self)
        collectionView.registerCell(ofType: FolderAddCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 24)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ellipsisView?.removeFromSuperview()
    }
}

private extension FolderViewController {
    func setupView() {
        view.backgroundColor = .gray30
        
        view.addSubview(explainView)
        explainView.addSubview(explainCountLabel)
        explainView.addSubview(explainTitleLabel)
        explainView.addSubview(explainSubLabel)
        explainView.addSubview(explainImageView)
        explainView.addSubview(explainPastButton)
        view.addSubview(collectionView)
        
//        setupNavigationBarUI()
        setupLayout()
        setupBinding()
    }
    
    func setupNavigationBarUI() {
        let button: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "searchBar"), for: .normal)
            return button
        }()
        
        let searchView = SearchViewController()
        searchView.modalPresentationStyle = .overFullScreen
        
        button.rx.tap
            .bind { [weak self] in
                self?.present(searchView, animated: false)
            }
            .disposed(by: disposeBag)
        
        let item = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = item
//        setupNavigationBar()
    }
    
    func setupLayout() {
        explainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
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
            make.top.equalTo(explainTitleLabel.snp.bottom).offset(8)
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
            make.top.equalTo(explainView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupBinding() {
        viewModel.fetchFolder()
        
        viewModel.folderList
            .bind(to: collectionView.rx.items) { _, row, item -> UICollectionViewCell in
                guard item != nil else {
                    let cell = self.collectionView.dequeueReusableCell(
                        for: IndexPath(row: row, section: 0)
                    ) as FolderAddCell
                    
                    return cell
                }
                
                let cell = self.collectionView.dequeueReusableCell(
                    for: IndexPath(row: row, section: 0)
                ) as FolderCell
                
                guard let item = item else { return UICollectionViewCell() }
                guard let itemColor = item.folderColor else { return UICollectionViewCell() }
                
                cell.setupData(title: item.folderName, count: item.wordCount, color: itemColor)
                cell.moreButton.tag = row
                cell.moreButton.addTarget(
                    self,
                    action: #selector(self.moreButtonWasTapped(_:)),
                    for: .touchUpInside)
                
                if row == 0 {
                    cell.moreButton.removeFromSuperview()
                }
                return cell
            }
            .disposed(by: self.disposeBag)
        
        collectionView.rx.itemSelected
            .bind { [weak self] in
                guard let self = self else { return }
                let count = self.viewModel.folderList.value.count
                
                self.ellipsisView?.removeFromSuperview()
                guard count != 12 && $0.last == count - 1 else {
                    //TODO: FolderDetailView 관련 코드 추가 예정
                    self.navigationController?.pushViewController(
                        FolderDetailViewController(),
                        animated: true)
                    return
                }
                self.addNewFolder()
            }.disposed(by: disposeBag)
    }
    
    @objc func moreButtonWasTapped(_ sender: UIButton) {
        ellipsisView?.removeFromSuperview()
        guard let folder = viewModel.folderList.value[sender.tag] else { return }
        
        let view: EllipsisView = {
            let view = EllipsisView()
            guard let color = folder.folderColor else { return view }
            
            view.addComponent(title: "수정하기", imageName: "edit", action: UIAction { _ in
                self.ellipsisView?.removeFromSuperview()
                self.moreButtonEditWasTapped(folderName: folder.folderName, folderColor: color)
            })
            view.addComponent(title: "삭제하기", imageName: "delete", action: UIAction { _ in
                self.ellipsisView?.removeFromSuperview()
                self.moreButtonDeleteWasTapped(
                    folderID: folder.folderID,
                    wordCount: folder.wordCount)
            })
            return view
        }()
        
        ellipsisView = view
        self.view.addSubview(ellipsisView ?? UIView())
        ellipsisView?.snp.makeConstraints { make in
            make.width.equalTo(108)
            make.height.equalTo(100)
            make.top.equalTo(sender.snp.bottom).offset(8)
            make.trailing.equalTo(sender.snp.trailing).offset(18)
        }
    }
    
    func moreButtonEditWasTapped(folderName: String, folderColor: UIColor) {
        //TODO: 작업 예정
    }
    
    func moreButtonDeleteWasTapped(folderID: String, wordCount: Int) {
        let view = DeletionAlertViewController(id: folderID, target: "폴더", wordCount: wordCount)
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        view.delegate = self
        self.present(view, animated: true, completion: nil)
    }
    
    func addNewFolder() {
        //TODO: 작업 예정
    }
}

extension FolderViewController: DeletionAlertDelegate {
    func cancelWasTapped() {}
    
    func deleteWasTapped(id: String) {
        viewModel.delete(id)
    }
}
