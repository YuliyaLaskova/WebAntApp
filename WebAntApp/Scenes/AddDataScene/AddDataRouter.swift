//
//  AddDataRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class AddDataRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: AddDataViewController) {
        self.view = view
    }

    func goBackToMainGallery() {
//        guard let navController = self.view?.navigationController else {
//            return
//        }
//          MainGalleryConfigurator.open(navigationController: navController)
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
         appDelegate?.openMainGalleryScreen(window: appDelegate?.window)
    }
}
