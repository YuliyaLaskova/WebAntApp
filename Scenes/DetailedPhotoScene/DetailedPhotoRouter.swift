//
//  DetailedPhotoRouter.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class DetailedPhotoRouter: BaseRouter {
    
    weak var view: UIViewController?
    
    init(_ view: DetailedPhotoViewController) {
        self.view = view
    }
    
    func openSomeScene() {
//        guard let navController = self.view?.navigationController else {
//            return
//        }
        //  SomeSceneConfigurator.open(navigationController: navController)
    }
}