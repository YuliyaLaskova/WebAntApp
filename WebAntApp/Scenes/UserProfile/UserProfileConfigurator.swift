//
//  UserProfileConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum UserProfileConfigurator {
    
    static func configure(view: UserProfileViewController) {
        let router = UserProfileRouter(view)
        let presenter = UserProfilePresenterImp(view, router, DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.userProfileStoryboard().instantiateInitialViewController() as? UserProfileViewController else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
