//
//  UICollectionView+Extensions.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/28.
//

import UIKit

extension UICollectionView {
    func registerCell(
        ofType cellType: UICollectionViewCell.Type,
        withReuseIdentifier identifier: String? = nil
    ) {
        let reuseIdentifier = identifier ?? String(describing: cellType.self)
        register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(
        withReuseIdentifier reuseIdentifier: String? = nil,
        for indexPath: IndexPath
    ) -> T {
        let reuseIdentifier = reuseIdentifier ?? String(describing: T.self)
        
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError()
        }
        
        return cell
    }
    
    func registerSupplementaryView(
        ofType viewType: UICollectionReusableView.Type,
        forSupplementaryViewOfKind elementKind: String = UICollectionView.elementKindSectionHeader,
        withReuseIdentifier identifier: String? = nil
    ) {
        let reuseIdentifier = identifier ?? String(describing: viewType.self)
        register(
            viewType,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: reuseIdentifier
        )
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(
        ofKind elementKind: String = UICollectionView.elementKindSectionHeader,
        reuseIdentifier: String? = nil,
        for indexPath: IndexPath
    ) -> T {
        let reuseIdentifier = reuseIdentifier ?? String(describing: T.self)
        
        guard let view = self.dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError()
        }
        
        return view
    }
}
