//
//  AddFolerView.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/12.
//

import UIKit

final class FolderAddEditView: UIView {
    private enum CollectionViewConstants {
        static let widthInset = 30
        static let width = UIScreen.main.bounds.width - CGFloat(Self.widthInset * 2)
        static let cellRatio = 0.152
    }
    
    private let colorList = [
        UIColor.folder01,
        UIColor.folder02,
        UIColor.folder03,
        UIColor.folder04,
        UIColor.folder05,
        UIColor.folder06,
        UIColor.folder07,
        UIColor.folder08,
        UIColor.folder09,
        UIColor.folder10,
        UIColor.folder11,
        UIColor.folder00
    ]
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let width = UIScreen.main.bounds.width - 48
        
        textField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backgroundColor = .white
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.width.height.equalTo(width)
            make.edges.equalToSuperview()
        }
        
        backgroundView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.leading.trailing.equalToSuperview()
        }
        
        backgroundView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        
        backgroundView.addSubview(colorLabel)
        colorLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(textField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
        }
        
        backgroundView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(width * 0.587)
            make.top.equalTo(colorLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension FolderAddEditView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return colorList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FolderAddEditViewCell",
            for: indexPath
        ) as? FolderAddEditViewCell else { return UICollectionViewCell() }
        let isLastIndex = indexPath.row == colorList.count - 1
        
        cell.setupColor(colorList[indexPath.row] ?? UIColor())
        
        if isLastIndex {
            cell.setupDisabled()
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
}

extension FolderAddEditView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
}

extension BottomSheetController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
