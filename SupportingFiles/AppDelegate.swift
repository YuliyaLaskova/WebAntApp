//
//  AppDelegate.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 06.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var settings: Settings?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        DI.initDependencies(appDelegate: self)

//            LocalSettings().clearUserData()

        
//        if UserDefaults.standard.object(forKey: UserDefaultsKey.token.rawValue) != nil {
//            print("token")
//            openMainGalleryScreen(window: self.window)
//        } else {
//            print("no token")
//            openStartScreen(window: self.window)
//        }
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}

extension AppDelegate {

    func openStartScreen(window: UIWindow?) {
        if let window = window {
            self.window = window
        }

        guard let window = self.window else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            return openStartScreen(window: nil)
        }
        DispatchQueue.main.async {
            let rootView = R.storyboard.welcomeStoryboard().instantiateInitialViewController()
            window.makeKeyAndVisible()
            window.rootViewController = rootView
        }
    }

    func openMainGalleryScreen(window: UIWindow?) {
        if let window = window {
            self.window = window
        }
        guard let window = self.window else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            return openMainGalleryScreen(window: nil)
        }
        DispatchQueue.main.async {
            let rootView = R.storyboard.rootStoryboard().instantiateInitialViewController()
            window.makeKeyAndVisible()
            window.rootViewController = rootView
        }
    }
}

extension AppDelegate: AuthResponseHandlerDelegate {

    func doLogout() {
        self.settings?.clearUserData()

        guard let navController = self.window?.rootViewController as? UINavigationController,
              navController.viewControllers.last as? SignInViewController != nil else {
            DispatchQueue.main.async {
                self.openStartScreen(window: self.window)
            }
            return
        }
    }
}
