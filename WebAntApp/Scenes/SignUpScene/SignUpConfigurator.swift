//
//  SignUpConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum SignUpConfigurator {
    static func configure(view: SignUpViewController) {
        let router = SignUpRouter(view)
        let presenter = SignUpPresenterImp(view: view, router: router, signUpUseCase: DI.resolve(), signInUseCase: DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.signUp().instantiateInitialViewController() as? SignUpViewController else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
