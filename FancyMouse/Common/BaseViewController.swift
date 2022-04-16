//
//  BaseViewController.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/03/27.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .primaryColor
    }
}
