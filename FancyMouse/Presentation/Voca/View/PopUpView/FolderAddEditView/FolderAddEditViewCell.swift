//
//  AddFolderViewCell.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/12.
//

import UIKit

final class FolderAddEditViewCell: UICollectionViewCell {
    private lazy var colorView = UIView()
    
    private lazy var colorLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.isHidden = true
        view.alpha = 0.4
        return view
    }()
    
    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check")
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var disabledImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "xmark")
        imageView.alpha = 0.5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayer()
    }
    
    override var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            setSelected(isSelected)
        }
    }
    
    private func setSelected(_ selected: Bool) {
        colorLayerView.isHidden = !selected
        checkImageView.isHidden = !selected
    }
    
    private func setup() {
        backgroundColor = .white
        
        addSubview(colorLayerView)
        colorLayerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(colorView)
        colorView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
        addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(17)
        }
    }
    
    private func setupLayer() {
        colorView.layer.cornerRadius = colorView.frame.width / 2
        colorLayerView.layer.cornerRadius = colorLayerView.frame.width / 2
    }
    
    func setupColor(_ color: UIColor) {
        colorView.backgroundColor = color
        colorLayerView.layer.borderColor = color.cgColor
    }
    
    func setupDisabled() {
        colorLayerView.isHidden = false
        
        addSubview(disabledImageView)
        disabledImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(18)
        }
    }
}
