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
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        flowLayout.minimumLineSpacing = 6
        flowLayout.scrollDirection = .vertical
        
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeWordCollectionView {
    func setupUI() {
        backgroundColor = .clear
        
        registerCell(ofType: HomeWordCell.self)
        registerSupplementaryView(ofType: HomeSectionHeaderView.self)
    }
}
