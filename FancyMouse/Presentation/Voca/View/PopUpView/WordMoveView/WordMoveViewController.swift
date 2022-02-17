//
//  WordMoveView.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/17.
//

import UIKit

final class WordMoveViewController: UIViewController {
    //Todo: DB연동 후 수정 예정
    private let mockData = ["폴더 01", "폴더 02",
                            "폴더 03", "폴더 04",
                            "폴더 05", "폴더 06",
                            "폴더 07", "폴더 08"]
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "단어 이동하기"
        label.font = .spoqaBold(size: 20)
        label.textColor = .primaryColor
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .primaryColor
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        let action = UIAction(handler: { _ in
            UIView.animate(withDuration: 0.25, animations: {
                self.containerView.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
                self.dismiss(animated: true)
            })
        })
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(WordMoveViewCell.self, forCellReuseIdentifier: "WordMoveViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setAnimation()
    }
    
    private func setup() {
        view.backgroundColor = .black.withAlphaComponent(0.85)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            let tableHeight = mockData.count < 6 ? 54 * mockData.count : 270
            make.top.equalTo(UIScreen.main.bounds.height)
            make.height.equalTo(149 + tableHeight)
            make.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(24)
        }
        
        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            let height = mockData.count < 6 ? 54 * mockData.count : 270
            make.height.equalTo(height)
            make.top.equalTo(titleLabel.snp.bottom).offset(41)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.containerView.transform = CGAffineTransform(
                translationX: 0,
                y: -self.containerView.frame.height
            )
        })
    }
}

extension WordMoveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "WordMoveViewCell",
            for: indexPath
        ) as? WordMoveViewCell else { return UITableViewCell() }
        
        cell.setupLabel(mockData[indexPath.row])
        //TODO: DB연동 후 수정 예정
        if indexPath.row == 0 {
            cell.setupSelected()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
