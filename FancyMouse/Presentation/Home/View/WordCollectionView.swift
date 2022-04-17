//
//  WordCollectionView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/04/17.
//

import RxCocoa
import RxSwift
import UIKit

final class WordCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(
            frame: frame,
            collectionViewLayout: UICollectionViewLayout()
        )
        
        collectionViewLayout = UICollectionViewCompositionalLayout(section: makeWordSection())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WordCollectionView {
    func setupUI() {
        backgroundColor = .gray30
        
        registerCell(ofType: WordCell.self)
        registerSupplementaryView(ofType: WordSectionHeaderView.self)
    }
    
    func makeWordSection() -> NSCollectionLayoutSection {
        let columns = 1
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(172)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: columns
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 12, leading: 24, bottom: 12, trailing: 24
        )
        section.interGroupSpacing = 12
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}
