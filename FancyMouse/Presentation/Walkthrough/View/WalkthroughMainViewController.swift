//
//  WalkthroughMainViewController.swift
//  FancyMouse
//
//  Created by suding on 2022/02/25.
//

import AuthenticationServices
import Firebase
import GoogleSignIn
import SnapKit
import UIKit

class WalkthroughMainViewController: UIViewController {
    private var currentIndex = 0
    
    lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .explainColor
        return view
    }()

    lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal,
                                                      options: nil)
        return pageViewController
    }()
    
    lazy var vc1: UIViewController = {
        let viewController = WalkthroughFirstViewController()
        return viewController
    }()

    lazy var vc2: UIViewController = {
        let viewController = WalkthroughSecondViewController()
        return viewController
    }()

    lazy var vc3: UIViewController = {
        let viewController = WalkthroughThirdViewController()
        return viewController
    }()

    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2, vc3]
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primaryColor
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .spoqaMedium(size: 16)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .secondaryColor
        pageControl.pageIndicatorTintColor = .gray60
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.preferredIndicatorImage = UIImage(named:"Rectangle")
        let action = UIAction(handler: { _ in
        })
        pageControl.addAction(action, for: .valueChanged)
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        configure()
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward,
                                                  animated: true, completion: nil)
        }
    }

    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }

    private func configure() {
        view.backgroundColor = .explainColor
        view.addSubview(navigationView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(pageControl)
        
        if case 0...1 = currentIndex {
            nextButton.setTitle("다음", for: .normal)
            nextButton.setTitleColor(.secondaryColor, for: .normal)
        }
        view.addSubview(nextButton)
        pageControl.currentPage = currentIndex
        
        navigationView.snp.makeConstraints { make in
            make.width.top.equalToSuperview()
            make.height.equalTo(94)
        }

        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(78)
        }
        pageViewController.didMove(toParent: self)
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
            make.height.equalTo(55)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-30)
        }
    }
}

extension WalkthroughMainViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController)
    -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        currentIndex = previousIndex
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }
}

extension WalkthroughMainViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController)
    -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        currentIndex = nextIndex
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
       guard completed,
         let currentVC = pageViewController.viewControllers?.first,
         let index = dataViewControllers.firstIndex(of: currentVC) else { return }
         pageControl.currentPage = index
        
        if index == 2 {
            nextButton.setTitle("Google로 시작하기", for: .normal)
            nextButton.setImage(#imageLiteral(resourceName: "_ic_chrome logo"), for: .normal)
            nextButton.setTitleColor(.secondaryColor, for: .normal)
            nextButton.imageView?.contentMode = .scaleAspectFit
            nextButton.titleLabel?.font = .spoqaMedium(size: 16)
            nextButton.contentHorizontalAlignment = .center
            nextButton.semanticContentAttribute = .forceLeftToRight
            nextButton.imageEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 32)
            let action = UIAction(handler: { _ in
                print("google")
                guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                let config = GIDConfiguration(clientID: clientID)
                GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
                    guard error == nil else {
                        return
                    }
                    guard let authentication = user?.authentication,
                          let idToken = authentication.idToken else {
                                   return
                    }
                    let credential
                    = GoogleAuthProvider.credential(withIDToken: idToken,
                                                    accessToken: authentication.accessToken)
                    Auth.auth().signIn(with: credential) { _, _ in
                        let nextVC = TabBarController()
                        nextVC.modalPresentationStyle = .overFullScreen
                        self.present(nextVC, animated: true)
                    }
                }
                UserDefaults.standard.set(true, forKey: "isLoginedUser")
            })
            nextButton.addAction(action, for: .touchUpInside)
        }
     }
}
