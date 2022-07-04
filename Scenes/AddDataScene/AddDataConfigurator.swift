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
    
    static func configure(view: AddDataViewController, photoForPost: UIImage) {
        let router = AddDataRouter(view)
        let presenter = AddDataPresenterImp(view, router, postPhotoUseCase: DI.resolve(), photoForPost)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController, photoForPost: UIImage) {
        guard let view = R.storyboard.addDataStoryboard().instantiateInitialViewController() as? AddDataViewController else {
            return
        }
        Self.configure(view: view, photoForPost: photoForPost)
        navigationController.pushViewController(view, animated: true)
    }
}
