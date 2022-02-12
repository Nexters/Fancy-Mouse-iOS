//
//  HomeViewController.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/22.
//

import UIKit

class HomeViewController: UIViewController, BottomSheetDelegate {
    func closeWasTapped() {
        print("close버튼 클릭")
    }
    
    func okWasTapped() {
        print("ok버튼 클릭")
    }
    
    let testButton: UIButton = {
        let button = UIButton()
        button.setTitle("버튼", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(testClicked), for: .touchUpInside)
        return button
    }()
    
    let testView = FilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    @objc func testClicked() {
        let bottomSheet = BottomSheetController(contentView: testView, title: "조건 선택하기", topInset: 40, bottomInset: 332)
        bottomSheet.delegate = self
        bottomSheet.setup(parentViewController: self)
    }
}
