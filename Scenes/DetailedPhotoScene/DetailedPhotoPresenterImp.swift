//
//  DetailedPhotoPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 01.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class DetailedPhotoPresenterImp: DetailedPhotoPresenter {
    
    private weak var view: DetailedPhotoView?
    private let router: DetailedPhotoRouter
    
    init(_ view: DetailedPhotoView,
         _ router: DetailedPhotoRouter) {
        self.view = view
        self.router = router
    }
    
}
