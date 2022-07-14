//
//  UserProfileRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 08.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class UserProfileRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: UserProfileViewController) {
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
