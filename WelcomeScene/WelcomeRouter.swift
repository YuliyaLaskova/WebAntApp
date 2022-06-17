//
//  WelcomeRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class WelcomeRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: WelcomeController) {
        self.view = view
    }
    
    func openSignInScene() {
        guard let navController = self.view?.navigationController else {
            return
        }

        SignInConfigurator.open(navigationController: navController)
    }

    func openSignUpScene() {
        guard let navController = self.view?.navigationController else {
            return
        }

        SignUpConfigurator.open(navigationController: navController)
    }
}
