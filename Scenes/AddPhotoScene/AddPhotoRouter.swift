//
//  AddPhotoRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class AddPhotoRouter: BaseRouter {
    
    weak var view: UIViewController?

    
    init(_ view: AddPhotoViewController) {
        self.view = view
    }

    func  openAddDataViewController(photoForPost: UIImage) {
        guard let navController = self.view?.navigationController else {
            return
        }
        AddDataConfigurator.open(navigationController: navController, photoForPost: photoForPost)
    }
}
