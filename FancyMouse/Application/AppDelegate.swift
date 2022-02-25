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
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
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
        GIDSignIn.sharedInstance()?.clientID = ""
        GIDSignIn.sharedInstance()?.delegate = self
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled { return true }
        return false
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
