//
//  HomeFilterView.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/25.
//


import RxSwift
import UIKit
//TODO: 리팩 기간에 삭제할 예정
final class HomeFilterView: UIView {
    private let disposeBag = DisposeBag()
    private let filterList = ["최신순", "오래된순", "A-Z순", "Z-A순"]
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = "정렬 순서"
        label.font = .spoqaMedium(size: 14)
        label.textColor = .gray60
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let collectionViewWidth = (UIScreen.main.bounds.width - 48)
        let widthSize = collectionViewWidth * 0.486
        let heightSize = widthSize * 0.301
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 9
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .white
        collectionView.registerCell(ofType: FilterViewCell.self)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(backgroundView)
        backgroundView.addSubview(titleLable)
        backgroundView.addSubview(collectionView)
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 48)
            make.height.equalTo((UIScreen.main.bounds.width - 48) * 0.409)
            make.edges.equalToSuperview()
        }
        
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        Observable.of(filterList)
            .bind(to: collectionView.rx.items) { (_, row, item) -> UICollectionViewCell in
                let cell = self.collectionView.dequeueReusableCell(
                    for: IndexPath(row: row, section: 0)
                ) as FilterViewCell
                cell.setupLabel(item)
                
                return cell
            }
            .disposed(by: self.disposeBag)
    }
}
