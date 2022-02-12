//
//  FilterView.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/08.
//

import UIKit

final class FilterView: UIView {
    private let title = [["최신순", "오래된순", "A-Z순", "Z-A순"], ["전체", "미암기", "암기중", "암기완료"]]
    private let type = ["정렬 순서", "암기상태"]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.486),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.146)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(9)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(26)
        )
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [headerElement]
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
        collectionView.register(
            FilterViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "FilterViewHeader"
        )
        collectionView.register(FilterViewCell.self, forCellWithReuseIdentifier: "FilterViewCell")
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트버튼", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(testFunc), for: .touchUpInside)
        return button
    }()
    
    @objc func testFunc() {
        print(888)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backgroundColor = .white
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 48)
            make.height.equalTo(UIScreen.main.bounds.width - 48).multipliedBy(0.868)
            make.top.leading.equalToSuperview()
        }
    }
}

extension FilterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FilterViewCell",
            for: indexPath
        ) as? FilterViewCell else { return UICollectionViewCell() }
        
        cell.title.text = title[indexPath.section][indexPath.row]
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "FilterViewHeader",
            for: indexPath
        ) as? FilterViewHeader else { return UICollectionReusableView() }
        
        headerView.title.text = type[indexPath.section]
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(1)
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FilterViewCell",
            for: indexPath
        ) as? FilterViewCell else { return }
        print(2)
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.gray70?.cgColor
        cell.title.font = .spoqaMedium(size: 14)
    }
}
