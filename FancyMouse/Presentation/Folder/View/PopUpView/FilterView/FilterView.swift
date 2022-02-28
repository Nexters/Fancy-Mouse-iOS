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
            heightDimension: .fractionalHeight(0.164)
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
            heightDimension: .absolute(30)
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
        collectionView.isScrollEnabled = false
        collectionView.registerSupplementaryView(ofType: FilterViewHeader.self)
        collectionView.registerCell(ofType: FilterViewCell.self)
        collectionView.allowsMultipleSelection = true
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
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backgroundColor = .white
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 48)
            make.height.equalTo((UIScreen.main.bounds.width - 48) * 0.892)
            make.edges.equalToSuperview()
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
        let cell = collectionView.dequeueCell(for: indexPath) as FilterViewCell
        cell.setupLabel(title[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let headerView = collectionView.dequeueSupplementaryView(for: indexPath) as FilterViewHeader
        headerView.setupLabel(type[indexPath.section])
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.indexPathsForSelectedItems?
            .filter {
                $0.section == indexPath.section &&
                $0.item != indexPath.item &&
                $0.row != indexPath.row
            }
            .forEach {
                collectionView.deselectItem(at: $0, animated: false)
            }
    }
}
