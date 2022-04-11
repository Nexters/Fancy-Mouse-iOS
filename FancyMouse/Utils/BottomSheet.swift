//
//  BottomSheet.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/31.
//

import SnapKit
import UIKit

protocol BottomSheetDelegate: AnyObject {
    func closeButtonWasTapped()
    func okButtonWasTapped()
}

final class BottomSheetController: UIViewController {
    private let contentView: UIView
    private let sheetTitle: String
    private let contentTopInset: CGFloat
    private let contentBottomInset: CGFloat
    
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
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primaryColor
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.secondaryColor, for: .normal)
        button.addTarget(self, action: #selector(okButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 80 / 255, green: 88 / 255, blue: 102 / 255, alpha: 1)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    // TODO: Custom Font 적용
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = sheetTitle
        label.font = .spoqaBold(size: 20)
        label.textColor = UIColor(red: 80 / 255, green: 88 / 255, blue: 102 / 255, alpha: 1)
        return label
    }()
    
    weak var delegate: BottomSheetDelegate?
    
    init(contentView: UIView, title: String, topInset: CGFloat, bottomInset: CGFloat) {
        self.contentView = contentView
        self.sheetTitle = title
        self.contentTopInset = topInset
        self.contentBottomInset = bottomInset
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc private func okButtonWasTapped() {
        defer { dismissSheet() }
        delegate?.okButtonWasTapped()
    }
    
    @objc private func closeButtonWasTapped() {
        defer { dismissSheet() }
        delegate?.closeButtonWasTapped()
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
    
    func setup(parentViewController: UIViewController) {
        guard let tabBarController = parentViewController.tabBarController else { return }
        
        tabBarController.addChild(self)
        tabBarController.view.addSubview(self.view)
        
        let screenBounds = UIScreen.main.bounds
        self.view.frame = screenBounds
        
        self.sheetView.frame.origin = CGPoint(x: 0, y: screenBounds.height)
        
        UIView.transition(with: self.view, duration: 0.25,
                          options: .curveEaseInOut, animations: {
            self.view.backgroundColor = .black.withAlphaComponent(0.4)
            self.sheetView.frame .origin = CGPoint(x: 0, y: 0)
        }, completion: nil)
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
            make.top.equalTo(titleLabel.snp.bottom).offset(contentTopInset)
            make.bottom.equalTo(okButton.snp.top).offset(-contentBottomInset)
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
}
