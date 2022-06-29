//
//  SignUpRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 10.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class SignUpRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: SignUpViewController) {
        self.view = view
    }

    func openMainGalleryScene()  {

        guard let navController = self.view?.navigationController else {
            return
        }
        MainGalleryConfigurator.open(navigationController: navController)
    }
    
    func openSignInScene() {
        guard let navController = self.view?.navigationController else {
            return
        }

        var isSignInViewControllerAlreadyExists:Bool = false

        let viewControllers:[UIViewController] = navController.viewControllers

        for vc in viewControllers where vc is SignInViewController {
            navController.popToViewController(vc, animated: true)
            isSignInViewControllerAlreadyExists = true
        }

        if !isSignInViewControllerAlreadyExists {
            SignInConfigurator.open(navigationController: navController)
        }
    }
}


