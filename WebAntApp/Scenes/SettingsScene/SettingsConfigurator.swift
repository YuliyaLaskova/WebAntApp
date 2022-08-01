//
//  SettingsConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum SettingsConfigurator {
    
    static func configure(view: SettingsViewController) {
        let router = SettingsRouter(view)
        let presenter = SettingsPresenterImp(view, router, DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.settingsStoryboard().instantiateInitialViewController() as? SettingsViewController else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
