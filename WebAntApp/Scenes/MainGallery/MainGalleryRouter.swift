//
//  MainGalleryRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class MainGalleryRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: MainGalleryViewController) {
        self.view = view
    }
    
    func openDetailedPhotoViewController(imageEntity: PhotoEntityForGet) {
        guard let navController = self.view?.navigationController else {
            return
        }
        DetailedPhotoConfigurator.open(navigationController: navController,
                                       imageModel: imageEntity)
    }
}
