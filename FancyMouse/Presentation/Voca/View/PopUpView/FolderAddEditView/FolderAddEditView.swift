//
//  AddFolerView.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/12.
//

import RxSwift

final class FolderAddEditView: UIView {
    lazy var viewModel = FolderAddEditViewModel(.init(), .init())
    private let disposeBag = DisposeBag()
    
    private enum CollectionViewConstants {
        static let widthInset = 30
        static let width = UIScreen.main.bounds.width - CGFloat(Self.widthInset * 2)
        static let cellRatio = 0.152
    }
    
    private lazy var backgroundView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 14)
        label.textColor = .gray60
        label.text = "폴더명"
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        
        textField.placeholder = "폴더명을 입력해 주세요."
        textField.layer.borderColor = UIColor.folderBorder?.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.font = .spoqaRegular(size: 14)
        label.textColor = .gray60
        label.text = "폴더 색상"
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let size = CollectionViewConstants.width * CollectionViewConstants.cellRatio
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 41
        layout.itemSize = CGSize(width: size, height: size)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.register(
            FolderAddEditViewCell.self,
            forCellWithReuseIdentifier: "FolderAddEditViewCell"
        )
        return collectionView
    }()
    
    init(frame: CGRect, originalNameString: String, originalColorString: String) {
        super.init(frame: frame)
        setupView()
        setupViewModel(originalNameString, originalColorString)
        setupLayout()
        setupBinding()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(textField)
        backgroundView.addSubview(colorLabel)
        backgroundView.addSubview(collectionView)
    }
    
    private func setupViewModel(_ originalNameString: String, _ originalColorString: String) {
        self.viewModel = FolderAddEditViewModel(originalNameString, originalColorString)
    }
    
    private func setupLayout() {
        let width = UIScreen.main.bounds.width - 48
        
        backgroundView.snp.makeConstraints { make in
            make.width.height.equalTo(width)
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        
        colorLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(textField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(width * 0.587)
            make.top.equalTo(colorLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        Observable.of(viewModel.colorList)
            .bind(to: collectionView.rx.items) { (_, row, item) -> UICollectionViewCell in
                guard let cell = self.collectionView.dequeueReusableCell(
                    withReuseIdentifier: "FolderAddEditViewCell",
                    for: IndexPath.init(row: row, section: 0)
                ) as? FolderAddEditViewCell else { return UICollectionViewCell() }
                let isLastIndex = row == self.viewModel.colorList.count - 1

                cell.setupColor(item ?? UIColor())

                if isLastIndex {
                    cell.setupDisabled()
                    cell.isUserInteractionEnabled = false
                }
                return cell
            }
            .disposed(by: self.disposeBag)
        
        viewModel.folderName
            .take(1)
            .filter { !$0.isEmpty }
            .bind {
                self.textField.text = $0
            }
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .bind(to: viewModel.folderName)
            .disposed(by: disposeBag)
        
        viewModel.folderColor
            .filter { !$0.isEmpty }
            .bind {
                let item = UIColor(named: $0)
                let index = IndexPath(
                    item: self.viewModel.colorList.firstIndex(of: item) ?? Int(),
                    section: 0
                )
                self.collectionView.selectItem(at: index, animated: false, scrollPosition: .init())
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(UIColor.self)
            .bind {
                guard let name = $0.name else { return }
                self.viewModel.folderColor.onNext(name)
            }
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEndOnExit)
            .bind {
                self.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
}

extension BottomSheetController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
