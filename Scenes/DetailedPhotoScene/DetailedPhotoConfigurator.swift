//
//  DetailedPhotoConfigurator.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import UIKit

enum DetailedPhotoConfigurator {
    
    static func configure(view: DetailedPhotoViewController, imageEntity: PhotoEntityForGet) {
//        let router = DetailedPhotoRouter(view)
        let presenter = DetailedPhotoPresenterImp(view: view, imageModel: imageEntity, settings: DI.resolve(), getUserUseCase: DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController, imageModel: PhotoEntityForGet) {
        guard let view = R.storyboard.detailedPhotoStoryboard().instantiateInitialViewController() as? DetailedPhotoViewController else {
            return
        }
        Self.configure(view: view, imageEntity: imageModel)
        navigationController.pushViewController(view, animated: true)
    }
}
