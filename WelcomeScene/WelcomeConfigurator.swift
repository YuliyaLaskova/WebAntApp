//
//  WelcomeConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum WelcomeConfigurator {
    
    static func configure(view: WelcomeController) {
        let router = WelcomeRouter(view)
        let presenter = WelcomePresenterImp(view, router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.welcomeStoryboard().instantiateInitialViewController()  as? WelcomeController else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
