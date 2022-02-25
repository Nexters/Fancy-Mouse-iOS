//
//  HomeViewController.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/22.
//

import UIKit

final class HomeViewController: UIViewController {
    private let progressView = HomeProgressView()
    
    private lazy var homeWordTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(
            HomeWordCell.self,
            forCellReuseIdentifier: "HomeWordCell"
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
    }
}

private extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .gray30
    }
    
    func setupLayout() {
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}
