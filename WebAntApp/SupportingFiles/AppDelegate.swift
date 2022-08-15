//
//  AppDelegate.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 06.06.2022.
//

import UIKit
import DBDebugToolkit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var settings: Settings?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        DI.initDependencies(appDelegate: self)
        DBDebugToolkit.setup()
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
        LocalSettings().clearUserData()
        // и открой стартовый экран --- TODO

        guard let navController = self.window?.rootViewController as? UINavigationController,
              // MARK: исправить экран контроллера
              // почему as? SignInViewController??? если конечно ориентироваться на baseapp
              //  navController.viewControllers.last as? SignInViewController != nil else {
                // пока изменила на WelcomeController
              navController.viewControllers.last as? WelcomeController != nil else {
            DispatchQueue.main.async {
                self.openStartScreen(window: self.window)
            }
            return
        }
    }
}
