//
//  WordTestCollectionView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/16.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class WordTestCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(
            frame: frame,
            collectionViewLayout: UICollectionViewLayout()
        )
        
        collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WordTestCollectionView {
    func setupUI() {
        backgroundColor = .gray30
        
        registerCell(ofType: WordProgressCell.self)
        registerCell(ofType: WordTestCell.self)
        registerSupplementaryView(ofType: WordTestSectionHeaderView.self)
        registerSupplementaryView(ofType: EmptySectionHeaderView.self)
    }
    
    func sectionProvider(
        sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection? {
        if sectionIndex == 0 {
            return makeProgressSectionLayout()
        }
        
        return makeWordTestSection(using: layoutEnvironment)
    }
    
    func makeProgressSectionLayout() -> NSCollectionLayoutSection {
        let columns = 1
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(305)
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
        
        return section
    }
    
    func makeWordTestSection(
        using layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
            let delete = UIContextualAction(
                style: .destructive,
                title: "????????????"
            ) { _, _, completion in
//                self?.delete(at: indexPath)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [delete])
        }
        configuration.showsSeparators = false
        
        let section = NSCollectionLayoutSection.list(
            using: configuration,
            layoutEnvironment: layoutEnvironment
        )
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
        sectionHeader.pinToVisibleBounds = true
        sectionHeader.zIndex = 2
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}
