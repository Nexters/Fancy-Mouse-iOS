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
    
    //TODO: 리팩 기간에 수정
    private var folderAddEditView: FolderAddEditView?
    private var folderList: [Folder]?
    private var selectedFolder: Folder?
    private var isNewFolder = true
    private var inputFolderName = ""
    private var inputFolderColorName = ""
    
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
            //TODO: 리팩 때 수정 (셀 쉐도우 짤림)
            make.top.equalTo(explainView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview().inset(24)
        }
    }
    
    private func setupBinding() {
        refreshData()
        viewModel.folderList
            .bind { [weak self] in
                self?.folderList = $0
            }
            .disposed(by: disposeBag)
        
        viewModel.folderCount
            .bind { [weak self] count in
//                self?.explainCountLabel.text = "\(count)"
                //TODO: 시연영상 찍고 돌려놓을 예정
                self?.explainCountLabel.text = "2"
            }
            .disposed(by: disposeBag)
        
        viewModel.folderList
            .bind(to: collectionView.rx.items) { (_, row, item) -> UICollectionViewCell in
                let cell = self.collectionView.dequeueCell(
                    for: IndexPath(row: row, section: 0)
                ) as FolderCell
                
                //TODO: 리팩 때 삭제 예정
                if row == (self.folderList?.count)! - 1 {
                    cell.setupAddButtonLayout()
                } else {
                    guard let itemColor = item.folderColor else { return UICollectionViewCell() }
                    cell.moreButton.tag = row
                    cell.moreButton.addTarget(self,
                                              action: #selector(self.moreButtonWasTapped(_:)),
                                              for: .touchUpInside
                    )
                    cell.setupFolderLayout()
                    cell.setupData(title: item.folderName, count: item.wordCount, color: itemColor)
                }
                return cell
            }
            .disposed(by: self.disposeBag)
        
        collectionView.rx.itemSelected
            .bind { [weak self] in
                self?.ellipsisView?.removeFromSuperview()
                guard let count = self?.folderList?.count else { return }
                guard $0.last == count - 1 else {
                    self?.navigationController?.pushViewController(FolderDetailViewController(), animated: true)
                    return
                }
                self?.addNewFolder()
            }.disposed(by: disposeBag)
    }
    
    //TODO: 리팩기간에 로직 수정하기
    @objc private func moreButtonWasTapped(_ sender: UIButton) {
        ellipsisView?.removeFromSuperview()
        guard let folder = folderList?[sender.tag] else { return }
        selectedFolder = folder
        
        let view: EllipsisView = {
            let view = EllipsisView()
            
            if let color = folder.folderColor {
                view.addComponent(title: "수정하기", imageName: "edit", action: UIAction { _ in
                    self.ellipsisView?.removeFromSuperview()
                    self.moreButtonEditWasTapped(folderName: folder.folderName, folderColor: color)
                })
                view.addComponent(title: "삭제하기", imageName: "delete", action: UIAction { _ in
                    self.ellipsisView?.removeFromSuperview()
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
        isNewFolder = false
        folderAddEditView = FolderAddEditView(frame: .zero, originalNameString: folderName, originalColorString: folderColor.name ?? "")

        let view = BottomSheetController(
            contentView: folderAddEditView ?? UIView(),
            title: "폴더 수정하기",
            topInset: 40,
            bottomInset: 40
        )
        //TODO: 리팩기간에 뷰모델 input-output으로 구성
        folderAddEditView?.viewModel.folderName
            .bind { [weak self] in
                self?.inputFolderName = $0
            }
            .disposed(by: disposeBag)
        folderAddEditView?.viewModel.folderColor
            .bind { [weak self] in
                self?.inputFolderColorName = $0
            }
            .disposed(by: disposeBag)
        let test = Observable.combineLatest((folderAddEditView?.viewModel.folderName)!, (folderAddEditView?.viewModel.folderColor)!)
            .map { name, color in
                return !name.isEmpty && !color.isEmpty
            }
        test.bind {
            view.okButton.isEnabled = $0
            view.okButton.backgroundColor = $0 ? .primaryColor : .gray40
            view.okButton.setTitleColor($0 ? .secondaryColor : .gray50, for: .normal)
        }.disposed(by: disposeBag)
        view.setup(parentViewController: self)
        view.delegate = self
    }
    private func moreButtonDeleteWasTapped(folderID: Int, wordCount: Int) {
        let view = DeletionAlertViewController(target: "폴더", wordCount: 3)
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        self.present(view, animated: true, completion: nil)
    }
    
    private func addNewFolder() {
        isNewFolder = true
        folderAddEditView = FolderAddEditView()
        
        let view = BottomSheetController(
            contentView: folderAddEditView ?? UIView(),
            title: "폴더 추가하기",
            topInset: 40,
            bottomInset: 40
        )
        //TODO: 리팩기간에 뷰모델 input-output으로 구성
        folderAddEditView?.viewModel.folderName
            .bind { [weak self] in
                self?.inputFolderName = $0
            }
            .disposed(by: disposeBag)
        folderAddEditView?.viewModel.folderColor
            .bind { [weak self] in
                self?.inputFolderColorName = $0
            }
            .disposed(by: disposeBag)
        let test = Observable.combineLatest((folderAddEditView?.viewModel.folderName)!, (folderAddEditView?.viewModel.folderColor)!)
            .map { name, color in
                return !name.isEmpty && !color.isEmpty
            }
        test.bind {
            view.okButton.isEnabled = $0
            view.okButton.backgroundColor = $0 ? .primaryColor : .gray40
            view.okButton.setTitleColor($0 ? .secondaryColor : .gray50, for: .normal)
        }.disposed(by: disposeBag)
        view.setup(parentViewController: self)
        view.delegate = self
        view.setup(parentViewController: self)
        view.delegate = self
    }
    
    func closeWasTapped() {}
    
    func okWasTapped() {
        //TODO: 리팩기간에 수정하기
        var folderColor = ""
        var folderName = ""
        
        folderAddEditView?.viewModel.folderColor
            .take(1)
            .bind { color in
                folderColor = color
            }
            .disposed(by: disposeBag)
        
        folderAddEditView?.viewModel.folderName
            .take(1)
            .bind { name in
                folderName = name
            }
            .disposed(by: disposeBag)
        
        if isNewFolder {
            viewModel.createFolder(folderName: folderName, folderColor: folderColor)
        } else {
            guard let folder = selectedFolder else { return }
            
            viewModel.update(folderID: folder.folderID,
                             folderColor: folderColor,
                             folderName: folderName
            )
        }
        refreshData()
        collectionView.reloadData()
    }
    
    //TODO: 리팩 기간에 삭제할 예정
    private func refreshData() {
        viewModel.fetchFolder()
    }
}
