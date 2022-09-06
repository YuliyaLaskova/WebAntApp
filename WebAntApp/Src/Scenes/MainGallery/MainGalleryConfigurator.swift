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
    static func configure(view: MainGalleryViewController, currentCollection: Int) {
        guard let collectionType = CollectionType(rawValue: currentCollection) else { return }
        let router = MainGalleryRouter(view)
        let presenter = MainGalleryPresenterImp(
            view: view,
            router: router,
            paginationUseCase: DI.resolve(),
            collectionType: collectionType
        )
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
       let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.openMainGalleryScreen(window: appDelegate?.window)
    }
}

