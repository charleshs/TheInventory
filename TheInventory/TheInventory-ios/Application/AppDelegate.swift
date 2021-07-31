//
//  AppDelegate.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/27.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if #available(iOS 13, *) {
            // Handled by SceneDelegate
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = AppRootFactory.shared.makeRoot()
            window?.makeKeyAndVisible()
        }

        AppearanceManager.shared.applyDefaultAppearance()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
