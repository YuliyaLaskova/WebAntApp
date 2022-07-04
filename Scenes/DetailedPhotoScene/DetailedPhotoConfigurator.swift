//
//  DetailedPhotoConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

enum DetailedPhotoConfigurator {
    
    static func configure(view: DetailedPhotoViewController) {
        let router = DetailedPhotoRouter(view)
        let presenter = DetailedPhotoPresenterImp(view, router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.detailedPhotoStoryboard().instantiateInitialViewController() as? DetailedPhotoViewController else {
            return
        }
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
