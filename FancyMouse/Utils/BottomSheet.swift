//
//  BottomSheet.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/31.
//

import SnapKit
import UIKit

protocol BottomSheetDelegate: AnyObject {
    func closeWasTapped()
    func okWasTapped()
}

final class BottomSheet: UIViewController {
    private let contentView: UIView
    private let sheetTitle: String
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let sheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // TODO: 자주 사용하는 컬러 extension으로 빼기
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 80 / 255, green: 88 / 255, blue: 102 / 255, alpha: 1)
        button.setTitle("확인", for: .normal)
        button.addTarget(self, action: #selector(okWasTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 80 / 255, green: 88 / 255, blue: 102 / 255, alpha: 1)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeWasTapped), for: .touchUpInside)
        return button
    }()
    
    // TODO: Custom Font 적용
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = sheetTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(red: 80 / 255, green: 88 / 255, blue: 102 / 255, alpha: 1)
        return label
    }()
    
    weak var delegate: BottomSheetDelegate?
    
    init(contentView: UIView, title: String) {
        self.contentView = contentView
        self.sheetTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    @objc private func okWasTapped() {
        defer { dismissSheet() }
        delegate?.okWasTapped()
    }
    
    @objc private func closeWasTapped() {
        defer { dismissSheet() }
        delegate?.closeWasTapped()
    }
    
    private func dismissSheet() {
        UIView.transition(with: self.view, duration: 0.25, options: .curveEaseInOut) {
            self.view.backgroundColor = .clear
            self.sheetView.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
        } completion: { _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    func set(parentVC: UIViewController) {
        if let tabBarController = parentVC.tabBarController {
            tabBarController.addChild(self)
            tabBarController.view.addSubview(view)
            
            let screenBounds = UIScreen.main.bounds
            self.view.frame = screenBounds
            
            self.sheetView.frame.origin = CGPoint(x: 0, y: screenBounds.height)
            
            UIView.transition(with: self.view, duration: 0.25,
                              options: .curveEaseInOut, animations: {
                self.view.backgroundColor = .black.withAlphaComponent(0.4)
                self.sheetView.frame .origin = CGPoint(x: 0, y: 0)
            }, completion: nil)
        }
    }
    
    private func setupLayout() {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        let safeAreaBottomInset = window?.safeAreaInsets.bottom ?? 0
        
        sheetView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(30)
            make.trailing.equalTo(closeButton.snp.leading)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.equalTo(okButton.snp.top).offset(-20)
        }
        
        okButton.snp.makeConstraints { make in
            make.height.equalTo(okButton.snp.width).multipliedBy(0.152)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                .offset(-(24 + safeAreaBottomInset))
        }
    }
    
    private func setupViews() {
        self.view.addSubview(sheetView)
        self.sheetView.addSubview(containerView)
        self.containerView.addSubview(closeButton)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(contentView)
        self.containerView.addSubview(okButton)
        self.containerView.layer.cornerRadius = 20
        self.okButton.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
