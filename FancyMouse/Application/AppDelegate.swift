//
//  AppDelegate.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/22.
//

import CoreData
import UIKit
import Firebase
import GoogleSignIn
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: CoreData
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "User")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        setupNavigationController()
        sleep(3)
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled { return true }
        return false
    }
    
    private func setupNavigationController() {
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "btn_back")?.withRenderingMode(.automatic).withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -18, bottom: 0, right: 0))
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "btn_back")?.withRenderingMode(.automatic).withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -18, bottom: 0, right: 0))
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
