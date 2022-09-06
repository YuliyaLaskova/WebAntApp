//
//  TablePresenterImp.swift
//  WebAntApp
//
//  Created by Yuliya Laskova on 19.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation

class TablePresenterImp: TablePresenter {
    
    private weak var view: TableView?
    private let router: TableRouter
    
    init(_ view: TableView,
         _ router: TableRouter) {
        self.view = view
        self.router = router
    }
    
}
