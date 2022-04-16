//
//  HomeWordCollectionView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/16.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class HomeWordCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: CollectionViewComponents.homeWordCollectionViewLayout)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeWordCollectionView {
    func setupUI() {
        backgroundColor = .gray30
        
        registerCell(ofType: HomeProgressView.self)
        registerCell(ofType: HomeWordCell.self)
        registerSupplementaryView(ofType: HomeSectionHeaderView.self)
        registerSupplementaryView(ofType: EmptySectionHeaderView.self)
    }
}

enum CollectionViewComponents {
    static let homeWordCollectionViewLayout: UICollectionViewLayout = {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return makeHomeWordProgressSectionLayout()
            }
            
            return makeHomeWordSection(using: layoutEnvironment)
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }()
    
    static func makeHomeWordProgressSectionLayout() -> NSCollectionLayoutSection {
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
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: columns)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        
        return section
    }
    
    static func makeHomeWordSection(
        using layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
            let delete = UIContextualAction(style: .destructive, title: "암기완료") { _, _, completion in
//                self?.delete(at: indexPath)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [delete])
        }
        configuration.showsSeparators = false
        
        let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
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
    
    static func makeWordDetailSection() -> NSCollectionLayoutSection {
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
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: columns)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
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
