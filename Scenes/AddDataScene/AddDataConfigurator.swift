//
//  AddDataConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum AddDataConfigurator {
    
    static func configure(view: AddDataViewController) {
        let router = AddDataRouter(view)
        let presenter = AddDataPresenterImp(view, router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.addDataStoryboard().instantiateInitialViewController() as? AddDataViewController else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
