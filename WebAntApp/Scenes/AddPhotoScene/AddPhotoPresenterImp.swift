//
//  AddPhotoPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import UIKit

class AddPhotoPresenterImp: AddPhotoPresenter {
    private weak var view: AddPhotoView?
    private let router: AddPhotoRouter
    
    init(_ view: AddPhotoView,
         _ router: AddPhotoRouter) {
        self.view = view
        self.router = router
    }

    func openAddDataViewController(photoForPost: UIImage) {
        router.openAddDataViewController(photoForPost: photoForPost)
    }

}
