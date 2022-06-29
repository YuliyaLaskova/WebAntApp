//
//  MainGalleryConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum MainGalleryConfigurator {
    
    static func configure(view: MainGalleryViewController) {
        let router = MainGalleryRouter(view)
        let presenter = MainGalleryPresenterImp(view, router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
//        guard let view = R.storyboard.mainGalleryStoryboard().instantiateInitialViewController() as? MainGalleryViewController else {
//            return
//        }
//        Self.configure(view: view)
//        navigationController.pushViewController(view, animated: true)
       let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.openMainGalleryScreen(window: appDelegate?.window)
    }
}

