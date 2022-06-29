//
//  AddDataPresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 28.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class AddDataPresenterImp: AddDataPresenter {
    
    private weak var view: AddDataView?
    private let router: AddDataRouter
    
    init(_ view: AddDataView,
         _ router: AddDataRouter) {
        self.view = view
        self.router = router
    }
    
}
