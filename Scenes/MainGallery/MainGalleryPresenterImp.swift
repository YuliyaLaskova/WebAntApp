//
//  MainGalleryPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 21.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class MainGalleryPresenterImp: MainGalleryPresenter {
    
    private weak var view: MainGalleryView?
    private let router: MainGalleryRouter
    
    init(_ view: MainGalleryView,
         _ router: MainGalleryRouter) {
        self.view = view
        self.router = router
    }
    
}
