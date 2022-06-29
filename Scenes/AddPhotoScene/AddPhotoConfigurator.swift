//
//  AddPhotoConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum AddPhotoConfigurator {
    
    static func configure(view: AddPhotoViewController) {
        let router = AddPhotoRouter(view)
        let presenter = AddPhotoPresenterImp(view, router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.addPhotoStoryboard().instantiateInitialViewController() as?  AddPhotoViewController else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
