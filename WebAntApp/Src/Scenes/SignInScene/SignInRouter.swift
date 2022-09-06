//
//  SignInRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class SignInRouter: BaseRouter {
    weak var view: UIViewController?
    
    init(_ view: SignInViewController) {
        self.view = view
    }

    func openMainGallery()  {
        guard let navController = self.view?.navigationController else {
            return
        }
        MainGalleryConfigurator.open(navigationController: navController)
    }

    func openSignUpScene() {
        guard let navController = self.view?.navigationController else {
            return
        }

        var isSignUpViewControllerAlreadyExists:Bool = false

        let viewControllers:[UIViewController] = navController.viewControllers

        for vc in viewControllers where vc is SignUpViewController {
            navController.popToViewController(vc, animated: true)
            isSignUpViewControllerAlreadyExists = true
        }

        if !isSignUpViewControllerAlreadyExists {
            SignUpConfigurator.open(navigationController: navController)
        }
    }
}

